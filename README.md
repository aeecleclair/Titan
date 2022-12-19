# Titan

Titan is a cross platform frontend for our project Hyperion

## Installing Flutter

<https://docs.flutter.dev/get-started/install>

## Configuring VS Code

<https://docs.flutter.dev/get-started/editor?tab=vscode>

## Change the backend url

In [`lib/tools/repository/repository.dart`](./lib/tools/repository/repository.dart) change:

```dart
final host = "http://10.0.2.2:8000/";
```

## Web dev

<https://docs.flutter.dev/get-started/web>

```bash
flutter build web
cd build/web
python -m http.server 8001
```

## Debug on the iOS simulator

<https://docs.flutter.dev/get-started/test-drive?tab=vscode>

## iOS export IPA

<https://stackoverflow.com/questions/58724420/how-to-create-ipa-file-in-flutter-for-testing-purpose>

## Export signed app bundles for the Play Store

<https://docs.flutter.dev/deployment/android>

> Don't forget to change the backend url

Follow [_Signing the app_](https://docs.flutter.dev/deployment/android#signing-the-app) steps.

Change the app version:

- `flutterVersionCode` in [android/app/build.gradle](./android/app/build.gradle)
- `flutterVersionName` in [android/app/build.gradle](./android/app/build.gradle)
- `version` in [pubspec.yaml](./pubspec.yaml)

> In pubspec `version` `flutterVersionCode` number should be used after the `+` sign

```bash
flutter build appbundle
```

## Export APKs

```bash
flutter build apk --split-per-abi
```

## Advanced

### Change the OAuth 2.0 client id

[`lib/auth/repositories/oauth2_repositoty.dart`](./lib/auth/repositories/oauth2_repositoty.dart)

### Allows non SSL connexion to use a custom local Hyperion backend

#### iOS

Add to `info.plist`

```
<key>CADisableMinimumFrameDurationOnPhone</key>
<true/>
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
	<key>NSExceptionDomains</key>
	<dict>
		<key>yourdomain.com</key>
		<dict>
			<key>NSIncludesSubdomains</key>
			<true/>
			<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
			<false/>
		</dict>
	</dict>
</dict>
```
