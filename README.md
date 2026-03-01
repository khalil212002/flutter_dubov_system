# Flutter Dubov System (FIDE-Approved Matchmaking)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev/)

A federated Flutter plugin that brings the **FIDE-approved [CPPDubovSystem](https://github.com/MichaelVShapiro/CPPDubovSystem/tree/main) engine** to the Dart ecosystem. This repository gives you the tools to generate official, completely accurate **Swiss system chess tournament pairings** right inside your Flutter apps.

Currently, this plugin specifically targets **Flutter Web** by running the underlying C++ engine via **WebAssembly (WASM)**.

## 🏗️ Repository Structure

This project uses Flutter's **federated plugin architecture** to keep things organized and easy to maintain. The repository is divided into three main packages:

| Package                                                                                       | Description                                                                                          | Pub.dev                                                                                                                                                      |
| :-------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 📦 **[`flutter_dubov_system`](./flutter_dubov_system)**                                       | **The Main Package.** If you're an app developer, this is the one you want to add to your project.   | [![pub package](https://img.shields.io/pub/v/flutter_dubov_system.svg)](https://pub.dev/packages/flutter_dubov_system)                                       |
| 🔌 **[`flutter_dubov_system_platform_interface`](./flutter_dubov_system_platform_interface)** | The common platform interface. It defines the base classes and data models (`Player`, `Tournament`). | [![pub package](https://img.shields.io/pub/v/flutter_dubov_system_platform_interface.svg)](https://pub.dev/packages/flutter_dubov_system_platform_interface) |
| 🌐 **[`flutter_dubov_system_web`](./flutter_dubov_system_web)**                               | The web implementation. It uses `dart:js_interop` to talk to the compiled C++ engine (`dubov.wasm`). | [![pub package](https://img.shields.io/pub/v/flutter_dubov_system_web.svg)](https://pub.dev/packages/flutter_dubov_system_web)                               |

## 🚀 Quick Start for App Developers

To use this plugin in your Flutter app, you only need to interact with the main package.

**1. Add the dependency:**

```yaml
dependencies:
  flutter_dubov_system: ^0.0.1
```

**2. Initialize and Generate Pairings:**

```Dart
import 'package:flutter_dubov_system/flutter_dubov_system.dart';

void main() async {
  // 1. Initialize the WASM engine (Required for Web)
  await DubovSystem.initialize();

  // 2. Create a tournament
  final tournament = DubovSystem.createTournament(3);

  // 3. Add players
  final p1 = DubovSystem.createPlayer('Khalil', 2850, 1, 0);
  final p2 = DubovSystem.createPlayer('Amir', 2790, 2, 0);
  tournament.addPlayer(p1);
  tournament.addPlayer(p2);

  // 4. Generate official FIDE pairings
  final pairings = tournament.generatePairings(1);

  // 5. Clean up C++ memory manually
  p1.delete();
  p2.delete();
  tournament.delete();
}
```

For more details and usage examples, check out the [main package](https://github.com/khalil212002/flutter_dubov_system/tree/master/flutter_dubov_system) README.

## 🧠 Technical Architecture & WebAssembly

Instead of trying to rewrite the well-tested, official C++ engine into Dart—which could accidentally introduce bugs or alter how pairings are calculated—we decided to compile the original [CPPDubovSystem](https://github.com/MichaelVShapiro/CPPDubovSystem/tree/main) source code directly into **WebAssembly** (`.wasm`).

The flutter_dubov_system_web package ships with the pre-compiled `dubov.wasm` binary.

I use modern `dart:js_interop` to pass Dart objects back and forth with the WASM environment.

Because the underlying engine is written in C++, you must manually free memory by calling `.delete()` on `Player` and `Tournament` objects when you're done with them. This is a quick step that prevents memory leaks in the browser.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
Copyright (c) 2026 Khalil Warwar.
