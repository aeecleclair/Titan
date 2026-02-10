# Titan

Titan is a cross platform frontend written in Flutter for an open-source project launched by ÉCLAIR, the computer science association of Ecole Centrale de Lyon. This project aims to provide students of business and engineering schools a digital tool to simplify the association process.

Our builds of Titan are called MyECL and can be downloaded from the App Store and from the Google Play Store.
Titan is designed to be launched on Web, Android and iOS platforms.

## 1. Setup your Flutter environment

- Install Flutter:
  https://docs.flutter.dev/get-started/install

<details>
<summary>Windows</summary>

If you get an error saying roughly:

```
because the execution of scripts is disabled on this system. Please see "get-help about_signing" for more details.
```

Then in a Powershell, run this to allow scripts executions for your user:

```ps1
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

</details>

- Setup VS Code for Flutter development:
  https://docs.flutter.dev/get-started/editor?tab=vscode

> [!TIP]
> Remember, if you have any problem with Flutter, don't hesitate to troubleshoot using:

```bash
flutter doctor
```

> [!NOTE]
> You do not need to have it all green: having Flutter correctly installed, a browser, and VS Code with the extensions is enough, most people don't need more than that!

## 2.Install dependencies

### Upgrade Flutter

Upgrade flutter to the latest stable version:

```bash
flutter upgrade
```

Upgrade Pub, which is the package manager of the Dart language, used by the Flutter framework:

```bash
flutter pub upgrade
```

### Install dependencies (for real)

Install the dependencies you'll need using Pub (referenced in the [pubspec.yaml](pubspec.yaml) file):

```bash
flutter pub get
```

> If you need to remove all modules from your virtual environnement, run:
>
> ```bash
> flutter clean
> ```

## 3. Complete the dotenv (`.env`)

> [!IMPORTANT]
> Copy the [`.env.template`](.env.template) file in a new `.env` file.

```bash
cp .env.template .env
```

You may update [`.env`](.env) to match your Hyperion backends.
If you host a Plausible instance, you may set Plausible's URL to get a few analytics.

> [!TIP]
> NB: a trailing slash is required at the end of every URL.

## 4. Launch the client

> [!WARNING]
> Beforehand, check that the Hyperion instance you want to connect to is up and running.

The Flutter app needs a host device to run. Below we assume, for development purposes, that you are about to run the **web** version.
NB: a device is a platform that can run the Flutter app; thus a browser does count as a device!

### Using VS Code

1. In the activity bar (the leftmost part), click the "Run and Debug" icon (the play button).
2. Click the green play button.
3. In the terminal, choose your device.

### Using the command-line interface

```bash
flutter run --flavor alpha
```

More generally you can use:

```bash
flutter run --flavor <your_flavor> [ -d <your_device> ]
```

- Where the flavor can be any of `dev`, `alpha`, or `prod` (whose policy is to only accept the prod client).
- Then in the interactive terminal, choose your device.
  Alternatively you can add a flag `-d` to indicate non-interactively your favorite device, for instance:

```bash
flutter run --flavor alpha -d chrome
flutter run --flavor dev -d web-server
```

### Check the app is running

Check that your Titan instance is up and running by waiting one minute until a browser window opens, or in the `web-server` case, by visiting yourself http://localhost:3000.

---

<details>
<summary>

# Beyond initial configuration

</summary>

## Development

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

### Flavors

Titan supports [flavors](https://docs.flutter.dev/deployment/flavors), which allows to easily switch between several versions of Titan for several use cases.

Titan includes 3 flavors: `dev`, `alpha`, `prod`. On VSCode, you can choose which flavor to use when launching the debugger

Each flavor is associated with a specific app package name (`fr.myecl.titan.dev`, `fr.myecl.titan.alpha`, `fr.myecl.titan`) allowing the three app to be installed on the same device. Each flavor use its own Hyperion url defined in the [dotenv](/.env)

#### Build with a flavor

To build Titan with a specific flavor use:

```
flutter build {target} --flavor={flavor}
```

Currently flavor are not supported for Flutter for web, you should use:

```
flutter build web --dart-define=flavor={flavor}
```

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

### Update Titan's icon

First update the icon's file and update [pubspec.yaml](./pubspec.yaml).

Then, `flutter_launcher_icons` must be updated:

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Upgrade Gradle version

[Guided upgrade using Android Studio](https://docs.flutter.dev/release/breaking-changes/android-java-gradle-migration-guide#solution-1-guided-fix-using-android-studio)
[Java and Gradle compatibility](https://docs.gradle.org/current/userguide/compatibility.html)

</details>
