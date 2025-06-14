import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/login/router.dart';
import 'package:myecl/routing/providers/has_minimal_version_provider.dart';
import 'package:myecl/routing/providers/is_app_loading_provider.dart';
import 'package:myecl/router.dart';
import 'package:myecl/version/class/version.dart';
import 'package:myecl/version/providers/version_verifier_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

const String forwardedFromKey = 'forwardedFrom';

final authRedirectServiceProvider = Provider<AuthRedirectService>((ref) {
  final versionVerifier = ref.watch(versionVerifierProvider);
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final isAppLoading = ref.watch(isAppLoadingProvider);
  final hasMinimalVersion = ref.watch(hasMinimalVersionProvider);
  final forwardedFrom = QR.params[forwardedFromKey]?.toString();

  return AuthRedirectService(
    ref,
    versionVerifier: versionVerifier,
    isLoggedIn: isLoggedIn,
    isAppLoading: isAppLoading,
    hasMinimalVersion: hasMinimalVersion,
    forwardedFrom: forwardedFrom,
  );
});

class AuthRedirectService {
  final Ref ref;
  final AsyncValue<Version> versionVerifier;
  final bool isLoggedIn;
  final bool isAppLoading;
  final bool hasMinimalVersion;
  final String? forwardedFrom;

  AuthRedirectService(
    this.ref, {
    required this.versionVerifier,
    required this.isLoggedIn,
    required this.isAppLoading,
    required this.hasMinimalVersion,
    required this.forwardedFrom,
  });

  /// Extracts the path from a given URI (without query parameters).
  /// Useful for consistent path comparisons.
  String segments(String path) {
    return Uri.parse(path).path;
  }

  /// Determines if the current path needs redirection based on the app state.
  String? getRedirect(String currentPath) {
    // Redirect to the loading page if the app is still initializing
    if (isAppLoading) {
      if (segments(currentPath) != AppRouter.loading) {
        return forward(AppRouter.loading, currentPath);
      }
      return null;
    }

    // Redirect if there's a network error
    // We can find a better way to handle this in the future
    if (versionVerifier.hasError) {
      return forward(AppRouter.noInternet, currentPath);
    }

    // Redirect if the app version is too old
    if (!hasMinimalVersion) {
      return AppRouter.update;
    }

    // Redirect to login if not authenticated
    if (!isLoggedIn) {
      return forward(LoginRouter.root, currentPath);
    }

    // If redirected before, consume the redirection target
    return consume(currentPath);
  }

  /// Returns a URL that redirects to [targetPath], keeping track of the original [fromPath].
  String? forward(String targetPath, String fromPath) {
    if (segments(targetPath) == segments(fromPath)) {
      return null;
    }

    final originUri = Uri.parse(fromPath);
    final targetUri = Uri.parse(targetPath);
    final originForwardedFrom = originUri.queryParameters[forwardedFromKey];

    if (originForwardedFrom != null) {
      // Preserve any existing redirection path
      return targetUri
          .replace(
            queryParameters: {
              ...targetUri.queryParameters,
              forwardedFromKey: segments(originForwardedFrom),
            },
          )
          .toString();
    }

    // Otherwise, forward the current path as the origin
    return targetUri
        .replace(
          queryParameters: {
            ...targetUri.queryParameters,
            forwardedFromKey: segments(fromPath),
          },
        )
        .toString();
  }

  /// If the current path has a redirection parameter, extract and return it.
  /// Clears query parameters to avoid repeated redirects.
  String? consume(String currentPath) {
    final currentUri = Uri.parse(currentPath);
    // The query parameters are immutable, so we create a mutable copy
    final oldQueryParams = Map<String, String>.from(currentUri.queryParameters);

    final newPath = oldQueryParams[forwardedFromKey];

    if (newPath == null || newPath.isEmpty) {
      return null;
    }

    // Remove the redirection parameter to prevent repeated redirects
    oldQueryParams.remove(forwardedFromKey);

    return Uri.parse(
      newPath,
    ).replace(queryParameters: oldQueryParams).toString();
  }
}
