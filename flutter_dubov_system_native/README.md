# flutter_dubov_system_native

The native platform implementation of `flutter_dubov_system`.

This package provides the native desktop (Windows, macOS, Linux) and mobile (Android, iOS) support for the `flutter_dubov_system` plugin using Dart FFI to interface directly with the **FIDE-compliant CPPDubovSystem** C++ engine.

## Features

- **High-Performance FFI Bindings**: Direct memory access to the C++ engine for near-native calculation speeds.
- **Cross-Platform Compilation**: Uses `native_assets_cli` and `native_toolchain_c` to automatically compile the C++ source during the Flutter build process (currently tested on Windows and Android).
- **Stable Object Identity**: Implements internal caching to ensure stable Dart object instances for players and tournaments.

## Usage

**This package is not meant to be used directly.** It is an endorsed implementation package for `flutter_dubov_system`.

If you want to use the Dubov pairing system in your Flutter app, please depend on the main package:

```yaml
dependencies:
  flutter_dubov_system: ^1.0.2
```

For documentation, usage examples, and more information, please refer to the [flutter_dubov_system main package](https://pub.dev/packages/flutter_dubov_system).
