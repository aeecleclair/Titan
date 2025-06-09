import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/logs/logger.dart';

enum HttpMethod { get, post, patch, delete, put }

abstract class Repository {
  static final String host = getTitanHost();
  static const String expiredTokenDetail = "Could not validate credentials";
  final String ext = "";
  final Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };
  final cacheManager = CacheManager();
  static final Logger logger = Logger();

  void initLogger() {
    logger.init();
  }

  /// Sets the authorization token in the request headers.
  /// This token will be used for all subsequent HTTP requests.
  void setToken(String token) {
    headers["Authorization"] = 'Bearer $token';
  }

  /// Handles common error parsing from HTTP responses.
  /// Logs the error and throws an [AppException] based on the error detail
  /// or a more general error if parsing fails.
  Never _handleErrorResponse(http.Response response, String endpoint) {
    logger.error(
      "HTTP Error for $endpoint: ${response.statusCode} - ${response.body}",
    );
    try {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final decoded = jsonDecode(decodedBody);
      if (decoded is Map && decoded["detail"] == expiredTokenDetail) {
        throw AppException(ErrorType.tokenExpire, decoded["detail"]);
      } else {
        throw AppException(
          ErrorType.apiError,
          decoded["detail"] ?? "Unknown API error",
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      logger.error("Error parsing error response for $endpoint: $e");
      throw AppException(
        ErrorType.unexpectedResponse,
        response.body.isEmpty
            ? "Server error"
            : utf8.decode(response.bodyBytes),
      );
    }
  }

  /// Executes an HTTP request, handles response processing, and manages caching.
  ///
  /// This private method centralizes the logic for making API calls,
  /// including successful response parsing, error handling, and
  /// caching mechanisms.
  ///
  /// [method]: The HTTP method to use (e.g., `HttpMethod.get`, `HttpMethod.post`).
  /// [path]: The full path relative to the host (e.g., "ext/suffix").
  /// [body]: The request body, if any. This is typically used for POST, PATCH, and PUT requests.
  /// [parseSuccess]: An optional callback function to parse a successful (2xx)
  /// response body. If not provided, `jsonDecode` is used by default.
  /// [onErrorDefault]: A required callback function that provides a default value
  /// to return in case of a network error or failure to read from cache (when caching is enabled).
  /// [cacheResponse]: A boolean indicating whether the successful response should be cached.
  /// This is ignored on web platforms.
  ///
  /// Returns a `Future<T>` which resolves to the parsed response data
  /// on success, or the default value provided by `onErrorDefault` on certain errors.
  ///
  /// Throws an [AppException] for API-specific errors, token expiration,
  /// invalid data decoding, or unexpected server responses.
  Future<T> _request<T>({
    required HttpMethod method,
    required String path,
    Object? body,
    T Function(String decodedBody)? parseSuccess,
    required T Function() onErrorDefault,
    bool cacheResponse = false,
  }) async {
    final uri = Uri.parse(host + path);
    logger.info("${method.name.toUpperCase()} $uri");

    parseSuccess =
        parseSuccess ?? (String decodedBody) => jsonDecode(decodedBody);

    try {
      http.Response response;
      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethod.post:
          response = await http.post(uri, headers: headers, body: body);
          break;
        case HttpMethod.patch:
          response = await http.patch(uri, headers: headers, body: body);
          break;
        case HttpMethod.delete:
          response = await http.delete(uri, headers: headers);
          break;
        case HttpMethod.put:
          response = await http.put(uri, headers: headers, body: body);
          break;
      }

      logger.info(
        "Response for ${method.name} $uri: ${response.statusCode} - ${response.body}",
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final String decodedBody = utf8.decode(response.bodyBytes);
          if (cacheResponse && !kIsWeb) {
            await cacheManager.writeCache(path, decodedBody);
          }
          return parseSuccess(decodedBody);
        } catch (e) {
          logger.error("Error decoding successful response for $uri: $e");
          throw AppException(
            ErrorType.invalidData,
            "Failed to decode API response",
          );
        }
      } else if (response.statusCode >= 400) {
        _handleErrorResponse(response, path); // This will throw an AppException
      } else {
        // Handle other non-2xx/4xx status codes (e.g., 3xx)
        logger.error(
          "Unexpected HTTP Status for $uri: ${response.statusCode} - ${response.body}",
        );
        throw AppException(
          ErrorType.unexpectedResponse,
          "Unexpected status code: ${response.statusCode}",
        );
      }
    } on AppException {
      rethrow; // Re-throw custom exceptions directly
    } catch (e) {
      logger.error("Network or unexpected error for $uri: $e");
      if (kIsWeb || !cacheResponse) {
        // Return the default value if cache is not used or on web
        return onErrorDefault();
      } else {
        // On mobile/desktop, try to read from cache on network error
        try {
          final cachedData = await cacheManager.readCache(path);
          logger.info("Successfully loaded from cache for $uri.");
          return parseSuccess(cachedData);
        } catch (cacheError) {
          logger.error("Error reading from cache for $uri: $cacheError");
          cacheManager.deleteCache(path); // Clear potentially invalid cache
          return onErrorDefault();
        }
      }
    }
  }

  /// Fetches a list of items from the API.
  ///
  /// The request is made to `ext/suffix`.
  /// On network errors, it attempts to return cached data.
  ///
  /// [suffix]: Optional additional path segment after the base `ext`.
  /// Returns a `Future` that resolves to a `List<T>`. Defaults to an empty list
  /// if no data is available from the network or cache.
  Future<List<T>> getList<T>({String suffix = ""}) async {
    return _request<List<T>>(
      method: HttpMethod.get,
      path: ext + suffix,
      onErrorDefault: () => [],
      cacheResponse: true,
    );
  }

  /// Fetches a single item by its ID from the API.
  ///
  /// The request is made to `ext/id/suffix`.
  /// On network errors, it attempts to return cached data.
  ///
  /// [id]: The identifier of the item to fetch.
  /// [suffix]: Optional additional path segment after the item ID.
  /// Returns a `Future` that resolves to an object of type `T`.
  /// Throws an [AppException] with `ErrorType.noDefaultValue` if the item
  /// is not found and no default value can be provided.
  Future<T> getOne<T>(String id, {String suffix = ""}) async {
    return _request<T>(
      method: HttpMethod.get,
      path: ext + id + suffix,
      onErrorDefault: () => throw AppException(
        ErrorType.noDefaultValue,
        "Item with ID $id not found",
      ),
      cacheResponse: true,
    );
  }

  /// Creates a new item by sending a POST request to the API.
  ///
  /// The request is made to `ext/suffix`. The provided object `t` is
  /// JSON-encoded and sent as the request body.
  ///
  /// [t]: The object to be created.
  /// [suffix]: Optional additional path segment.
  /// Returns a `Future` that resolves to an object of type `T` representing
  /// the created item. Throws an [AppException] on creation failure.
  Future<T> create<T>(dynamic t, {String suffix = ""}) async {
    return _request<T>(
      method: HttpMethod.post,
      path: ext + suffix,
      body: jsonEncode(t),
      onErrorDefault: () =>
          throw AppException(ErrorType.noDefaultValue, "Error creating item"),
      cacheResponse: false,
    );
  }

  /// Updates an existing item by sending a PATCH request to the API.
  ///
  /// The request is made to `ext/id/suffix`. The provided object `t` is
  /// JSON-encoded and sent as the request body.
  ///
  /// [t]: The object with updated fields.
  /// [tId]: The identifier of the item to update.
  /// [suffix]: Optional additional path segment.
  /// Returns a `Future` that resolves to `true` on successful update, `false` otherwise.
  Future<bool> update(dynamic t, String tId, {String suffix = ""}) async {
    return _request<bool>(
      method: HttpMethod.patch,
      path: ext + tId + suffix,
      body: jsonEncode(t),
      parseSuccess: (decodedBody) {
        return true; // Assuming a successful PATCH returns a 2xx status code
      },
      onErrorDefault: () => false,
      cacheResponse: false,
    );
  }

  /// Deletes an item by sending a DELETE request to the API.
  ///
  /// The request is made to `ext/id/suffix`.
  ///
  /// [tId]: The identifier of the item to delete.
  /// [suffix]: Optional additional path segment.
  /// Returns a `Future` that resolves to `true` on successful deletion, `false` otherwise.
  Future<bool> delete(String tId, {String suffix = ""}) async {
    return _request<bool>(
      method: HttpMethod.delete,
      path: ext + tId + suffix,
      parseSuccess: (decodedBody) {
        return true; // Assuming a successful DELETE returns a 2xx status code
      },
      onErrorDefault: () => false,
      cacheResponse: false,
    );
  }
}
