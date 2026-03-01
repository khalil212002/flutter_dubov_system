# Flutter Dubov System

[![pub package](https://img.shields.io/pub/v/flutter_dubov_system.svg)](https://pub.dev/packages/flutter_dubov_system)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A high-performance Flutter plugin providing a Dart wrapper for the **CPPDubovSystem** engine. This package allows developers to easily integrate **FIDE-approved Swiss system tournament pairing logic** into Flutter applications, specifically targeting the web via WebAssembly.

## Key Features

- **FIDE-Approved Engine:** Built on top of the robust CPPDubovSystem core, which is officially recognized by the International Chess Federation (FIDE) for official tournament matchmaking.
- **WebAssembly (WASM) Implementation:** Utilizes a compiled C++ version of the pairing logic to ensure near-native calculation speeds and absolute precision directly within the browser.
- **Federated Architecture:** Designed for scalability, separating the public API from the platform-specific implementation to allow for future desktop/mobile expansion.
- **Complete Pairing Logic:** Fully supports chess player management, Elo rating tracking, color allocation (White/Black), and the automated generation of official Dubov Swiss pairings.

## Getting Started

### Web Support & Initialization

The current implementation leverages WASM to run the C++ chess engine. You must initialize the engine before performing any tournament operations.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dubov_system/flutter_dubov_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DubovSystem.initialize();
  runApp(const MyApp());
}
```

### Basic Usage

⚠️ Important Memory Management Note: Because this package bridges Dart with a C++ WASM instance, Dart's garbage collector cannot automatically clean up the underlying C++ objects. You must manually call .delete() on your players and tournaments once they are no longer needed to prevent memory leaks.

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

This package acts as a highly efficient bridge between the Flutter framework and the CPPDubovSystem C++ library. By utilizing dart:js_interop, it invokes the pairing routines compiled into the dubov.wasm binary. This architecture ensures that the complex algorithmic logic remains identical to the FIDE-approved source code while executing rapidly on the web client.
