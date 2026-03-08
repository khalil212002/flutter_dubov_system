# flutter_dubov_system_web

The web platform implementation of `flutter_dubov_system`.

This package provides the Flutter Web support for the `flutter_dubov_system` plugin by compiling the **FIDE-compliant CPPDubovSystem** C++ engine to WebAssembly (WASM).

## Features

- **Near-Native Performance**: Leverages WebAssembly to execute complex pairing algorithms at near-native speeds in the browser.
- **WASM Interop**: Uses modern `dart:js_interop` to communicate between Dart and the WASM runtime.
- **Bundled Assets**: The `dubov.wasm` and `dubov.js` binaries are securely bundled with the package for easy deployment.
- **Stable Object Identity**: Ensures consistent object instances for players and tournaments, facilitating easier state management in web apps.

## Usage

**This package is not meant to be used directly.** It is an endorsed implementation package for `flutter_dubov_system`.

If you want to use the Dubov pairing system in your Flutter app, please depend on the main package:

```yaml
dependencies:
  flutter_dubov_system: ^1.0.2
```

For documentation, usage examples, and more information, please refer to the [flutter_dubov_system main package](https://pub.dev/packages/flutter_dubov_system).
