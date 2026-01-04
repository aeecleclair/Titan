# Titan

Titan is a cross platform frontend written in Flutter for an open-source project launched by ÉCLAIR and maintained by ProximApp. This project aims to provide students of business and engineering schools a digital tool to simplify campus life and student association activities.

## Flavors

Titan supports [flavors](https://docs.flutter.dev/deployment/flavors), which allows the developer to easily switch between several versions of Titan for several use cases.

Titan includes 3 flavors: `dev`, `alpha`, `prod`. On VSCode, you can choose which flavor to use when launching the debugger

Each flavor is associated with a specific app package name (`*.titan.dev`, `*.titan.alpha`, `*.titan`) allowing the three app to be installed simultaneously on the same device.

## Base configuration

You need to create config json files with required variables:

- config/config-dev.json
- config/config-alpha.json
- config/config-prod.json

## Development

### Setup dev environment

Install Flutter:
https://docs.flutter.dev/get-started/install

Setup VS Code for Flutter development:
https://docs.flutter.dev/get-started/editor?tab=vscode

Titan is designed to be launched on Web, Android and iOS platforms.

### Run Titan

```bash
flutter run --flavor dev --dart-define-from-file=config/config-dev.json --web-port 3000
# flutter run --flavor alpha --dart-define-from-file=config/config-alpha.json --web-port 3000
# flutter run --flavor prod --dart-define-from-file=config/config-prod.json --web-port 3000
```

Titan can be launched from VS Code _Run and Debug_ menu.

### Formatting

To format code use `dart format .`

```
dart format .
```

### Linting

Titan support linting according to the official [Flutter static analysis options](https://dart.dev/guides/language/analysis-options).

The linter can be launched using:

```
dart analyze
```

Dart allows you to fix issues in your code with the dart command `dart fix`.

To preview proposed changes, use the `--dry-run` flag:

```
dart fix --dry-run
```

To apply the proposed changes, use the --apply flag:

```
dart fix --apply
```

### Testing

Titan's tests follow the official [Flutter documentation](https://docs.flutter.dev/testing).

Tests can be run using:

```bash
flutter test --flavor dev
```

To run a specific test file :

```bash
flutter test --flavor dev path/to/file.dart
```

## Advanced Configuration

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

<details>
<summary>

On mobile, using plaintext HTTP connexions may raise issues.

</summary>

#### Android

Update [AndroidManifest.xml](./android/app/src/debug/AndroidManifest.xml):

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

</details>

### Update Titan's icon

First update the icon's file and update [pubspec.yaml](./pubspec.yaml).

Then run `flutter_launcher_icons` to generate all variants of the icon:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Upgrade Gradle version

[Guided upgrade using Android Studio](https://docs.flutter.dev/release/breaking-changes/android-java-gradle-migration-guide#solution-1-guided-fix-using-android-studio)
[Java and Gradle compatibility](https://docs.gradle.org/current/userguide/compatibility.html)

## Building using Fastlane

### Fastlane configuration

For automated signature and upload, you need to provide the following keys:

- Google service account

```
android/fastlane-service-account.json
```

- Apple App Store Connect API key

```
ios/app-store-connect-api.p8
```

### Build and upload a version

```bash
cd ios # or android
bundle exec fastlane beta flavor:alpha # or prod or dev
```

### Update Fastlane

```bash
bundle update fastlane
cd ios
bundle update fastlane
cd android
bundle update fastlane
```