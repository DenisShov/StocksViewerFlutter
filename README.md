# stocks_viewer_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configuring the Polygon API key

The app reads its Polygon.io API key from a build-time Dart define. No
version-controlled file holds the key value, so it must be supplied at run
or build time using one of the two invocations below.

### Option 1: `--dart-define`

Pass the key directly on the command line:

```sh
flutter run --dart-define=POLYGON_API_KEY=<key>
```

### Option 2: `--dart-define-from-file`

1. Copy `dart_defines/local.json.example` to `dart_defines/local.json`.
2. Fill in your key:

   ```json
   {
     "POLYGON_API_KEY_FILE": "<key>"
   }
   ```

3. Run with the file:

   ```sh
   flutter run --dart-define-from-file=dart_defines/local.json
   ```

`dart_defines/local.json` is listed in `.gitignore` and must never be
committed. If both a `--dart-define` and a `--dart-define-from-file` value
are supplied, the `--dart-define` value takes precedence.
