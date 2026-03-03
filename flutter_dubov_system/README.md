# Flutter Dubov System

[![pub package](https://img.shields.io/pub/v/flutter_dubov_system.svg)](https://pub.dev/packages/flutter_dubov_system)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A high-performance cross-platform Flutter plugin providing a Dart wrapper for the **CPPDubovSystem** engine. This package allows developers to easily integrate **FIDE-approved Swiss system tournament pairing logic** into Flutter applications across Web, Desktop, and Mobile.

> ⚠️ **Platform Support Notice:** > This package has currently only been tested on **Windows, Web, and Android**. While the federated architecture and Dart FFI are designed to support all platforms, you might need to make adjustments to the native package's `build.dart` hook to successfully compile the C++ engine on macOS, Linux, or iOS. Contributions and PRs for these platforms are welcome!

## Key Features

- **Cross-Platform Support:** Seamlessly works on Android, Windows, and Web (via WebAssembly), with FFI foundations for iOS, macOS, and Linux.
- **FIDE-Approved Engine:** Built on top of the robust CPPDubovSystem core, which is officially recognized by the International Chess Federation (FIDE) for official tournament matchmaking.
- **High Performance:** Utilizes compiled C++ bindings to ensure near-native calculation speeds and absolute precision, regardless of the platform.
- **Complete Pairing Logic:** Fully supports chess player management, Elo rating tracking, color allocation (White/Black), and the automated generation of official Dubov Swiss pairings.

## Getting Started

### Initialization

Before performing any tournament operations, you must initialize the engine. This is particularly important for the Web implementation, which needs to asynchronously load the WASM binary.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dubov_system/flutter_dubov_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DubovSystem.initialize(); // Required to initialize WASM on web, safe to call on all platforms
  runApp(const MyApp());
}
```

### Basic Usage

⚠️ Important Memory Management Note: Because this package bridges Dart with a C++ instance, Dart's garbage collector cannot automatically clean up the underlying C++ objects. You must manually call .delete() on your players and tournaments once they are no longer needed to prevent memory leaks.

```dart
final tournament = DubovSystem.createTournament(3);

final p1 = DubovSystem.createPlayer('Khalil', 2850, 1, 0);
final p2 = DubovSystem.createPlayer('Amir', 2790, 2, 0);

tournament.addPlayer(p1);
tournament.addPlayer(p2);

tournament.setRound1Color(true);

final pairings = tournament.generatePairings(1);

for (var match in pairings) {
  if (match.isBye) {
    print('${match.white.name} receives a BYE');
  } else {
    print('${match.white.name} (White) vs ${match.black.name} (Black)');
  }
}

p1.delete();
p2.delete();
tournament.delete();
```

## Technical Details

This package acts as a highly efficient bridge between the Flutter framework and the CPPDubovSystem C++ library using a federated plugin architecture:

- **Native Platforms** (Mobile/Desktop): Utilizes dart:ffi to directly bind to the compiled C++ library.

- **Web Platform**: Utilizes dart:js_interop to invoke routines compiled into a dubov.wasm binary.

This architecture ensures that the complex algorithmic logic remains identical to the FIDE-approved source code while executing rapidly across every Flutter target.
