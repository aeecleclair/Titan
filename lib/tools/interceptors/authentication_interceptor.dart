// import 'dart:async';
// import 'dart:io';

// import 'package:chopper/chopper.dart';
// import 'package:myecl/generated/openapi.swagger.dart';

// class MyAuthenticator implements Authenticator {
//   MyAuthenticator(this._repo);

//   final Openapi _repo;
//   Completer<String>? _completer;

//   @override
//   FutureOr<Request?> authenticate(
//     Request request,
//     Response response, [
//     Request? originalRequest,
//   ]) async {
//     print('[MyAuthenticator] response.statusCode: ${response.statusCode}');
//     print(
//       '[MyAuthenticator] request Retry-Count: ${request.headers['Retry-Count'] ?? 0}',
//     );

//     // 401
//     if (response.statusCode == HttpStatus.unauthorized) {
//       // Trying to update token only 1 time
//       if (request.headers['Retry-Count'] != null) {
//         print(
//           '[MyAuthenticator] Unable to refresh token, retry count exceeded',
//         );
//         return null;
//       }

//       try {
//         final newToken = await _refreshToken();

//         return applyHeaders(
//           request,
//           {
//             HttpHeaders.authorizationHeader: newToken,
//             // Setting the retry count to not end up in an infinite loop
//             // of unsuccessful updates
//             'Retry-Count': '1',
//           },
//         );
//       } catch (e) {
//         print('[MyAuthenticator] Unable to refresh token: $e');
//         return null;
//       }
//     }

//     return null;
//   }

//   Future<String> _refreshToken() {
//     var completer = _completer;
//     if (completer != null && !completer.isCompleted) {
//       print('Token refresh is already in progress');
//       return completer.future;
//     }

//     completer = Completer<String>();
//     _completer = completer;

//     _repo.refreshToken().then((_) {
//       // Completing with a new token
//       completer?.complete(_repo.accessToken);
//     }).onError((error, stackTrace) {
//       // Completing with an error
//       completer?.completeError(error ?? 'Refresh token error', stackTrace);
//     });

//     return completer.future;
//   }
  
//   @override
//   // TODO: implement onAuthenticationFailed
//   AuthenticationCallback? get onAuthenticationFailed => throw UnimplementedError();
  
//   @override
//   // TODO: implement onAuthenticationSuccessful
//   AuthenticationCallback? get onAuthenticationSuccessful => throw UnimplementedError();
// }
