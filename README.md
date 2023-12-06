# Titan

Titan is a cross platform frontend written in Flutter for an open-source project launched by ÉCLAIR, the computer science association of Ecole Centrale de Lyon. This project aims to provide students of business and engineering schools a digital tool to simplify the association process.

Our builds of Titan are called MyECL and can be downloaded from the App Store and from the Google Play Store.

## Setup environment

Install Flutter:
https://docs.flutter.dev/get-started/install

Setup VS Code for Flutter development:
https://docs.flutter.dev/get-started/editor?tab=vscode

Titan is designed to be launched on Web, Android and iOS platforms.

## Configure Titan

Update [`.env`](.env) to match your Hyperion's backend:

`RELEASE_HOST = "<<Your Production Server Host>>"`

You can also specify an other host for debuging:

`DEBUG_HOST = "<<Your Debbuging Server Host>>"`

NB: a trailing slash is required.

## Development

### Linting
Titan support linting according to the official [Flutter static analysis options](https://dart.dev/guides/language/analysis-options).

The linter can be launched using:
```
dart format .
flutter analyze --fix
```

### Testing

Titan's tests follow the official [Flutter documentation](https://docs.flutter.dev/testing).

Tests can be run using:
```bash
flutter test
```

To run a specific test file :
```bash
flutter test path/to/file.dart
```

### Flavors

Titan supports [flavors](https://docs.flutter.dev/deployment/flavors), which allows to easily switch between several versions of Titan for several use cases.

Titan includes 3 flavors: dev, alpha, prod. On VSCode, dev flavor is launched by default.

### Notifications setup

Notifications are handled using the Firebase Cloud Messaging API. On mobile platforms, a valid notification configuration is required to debug Titan. Notifications are disabled on web builds.

Please refer to the [documentation](https://pub.dev/packages/firebase_messaging) of the corresponding Flutter's package to correctly setup notifications.

Please follow [Android](https://firebase.google.com/docs/cloud-messaging/android/client) or [iOS](https://firebase.google.com/docs/cloud-messaging/ios/client) Firebase documentation to setup notifications.

#### Android FCM config file
For Android, add your `google-services.json` in `android/app/src/<flavor>/`.

#### iOS FCM config file
For iOS, add your `GoogleService-Info.plist` in `ios/config/<flavor/`.

## Advanced

### Allows non SSL connexion to use a custom local Hyperion backend

On mobile, using plaintext HTTP connexions may raise issues.

#### Android
Update [AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml):
```
<application
    ...
    android:usesCleartextTraffic="true"
    ...   >
```

#### iOS
Update [Info.plist](ios/Runner/Info.plist):

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

### Update Titan's icon

First update the icon's file and update [pubspec.yaml](./pubspec.yaml).

Then, `flutter_launcher_icons` must be updated:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```