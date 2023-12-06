# Titan

Titan is a cross platform frontend for our project Hyperion

## Installing Flutter

<https://docs.flutter.dev/get-started/install>

## Configuring VS Code

<https://docs.flutter.dev/get-started/editor?tab=vscode>

## Change the backend url

In [`.env`](.env) change:

RELEASE_HOST = "<<Your Production Server Host>>"

You can also specify a debug url :

DEBUG_HOST = "<<Your Debbuging Server Host>>"

## Web dev

<https://docs.flutter.dev/get-started/web>

```bash
flutter build web
cd build/web
python -m http.server 8001
```

## Testing

<https://docs.flutter.dev/testing>

```bash
flutter test
```

If you want to run a specific test file :

```bash
flutter test path/to/file.dart
```

## Linting

<https://dart.dev/guides/language/analysis-options>

```bash
flutter analyze
```

To fix some issues :

```bash
dart fix --apply
```

## Formatting

```bash
dart format .
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

#### Android

Add to `AndroidManifest.xml` file in the android/app/src/main folder :

```
<application
    ...
    android:usesCleartextTraffic="true"
    ...   >
```

## Mettre à jour l'icon de l'app

On utilise le module [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), après avoir modifié la config dans [pubspec.yaml](./pubspec.yaml) executer :

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## Use the linter

```
dart format .
flutter analyze
```
