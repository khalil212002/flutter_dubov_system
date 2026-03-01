# flutter_dubov_system_web

The web implementation of the `flutter_dubov_system` plugin, bringing **FIDE-approved chess tournament pairings** to Flutter Web.

This package enables high-performance, official **Swiss system matchmaking** directly in your browser by utilizing the renowned CPPDubovSystem C++ engine compiled to **WebAssembly (WASM)**. It is the perfect solution for building scalable, web-based chess tournament managers and companion apps.

## Features

- The officially endorsed web implementation for the `flutter_dubov_system` chess plugin.
- Leverages **WebAssembly (`dubov.wasm`)** to bring the native C++ performance of complex chess pairing algorithms directly to Flutter Web.
- Utilizes `dart:js_interop` to seamlessly bridge the Dart framework with the compiled FIDE chess engine logic.
- Fully supports player creation, **Elo rating management**, color allocation (White/Black), and automated round pairings according to strict **International Chess Federation (FIDE)** rules.

## Usage

This package is **not** intended to be depended on directly by app developers. It is automatically endorsed and utilized by the framework when you use the main `flutter_dubov_system` package and build your chess app for a web target.

To use the Dubov System in your Flutter project, simply add the main package to your project:

```yaml
dependencies:
  flutter_dubov_system: ^0.0.1
```
