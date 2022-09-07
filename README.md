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

## Advanced

### Change the OAuth 2.0 client id

[`lib/auth/repositories/oauth2_repositoty.dart`](./lib/auth/repositories/oauth2_repositoty.dart)
