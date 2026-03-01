# Flutter Dubov System

A high-performance Flutter plugin providing a Dart wrapper for the CPPDubovSystem engine. This plugin allows developers to integrate the FIDE-approved Dubov pairing logic into Flutter applications, specifically targeting the web via WebAssembly.

## Key Features

- FIDE-Approved Engine: Built on top of the CPPDubovSystem core, which is officially recognized by the International Chess Federation (FIDE) for tournament pairings.

- WebAssembly (WASM) Implementation: Uses a compiled C++ version of the pairing logic to ensure near-native performance and precision within the browser.

- Federated Architecture: Designed for scalability, separating the public API from the platform-specific implementation.

- Complete Pairing Logic: Supports player management, rating tracking, and automated generation of official Dubov pairings.

## Getting Started

Web Support
The current implementation leverages WASM to run the C++ engine. You must initialize the engine before performing any tournament operations:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_dubov_system/flutter_dubov_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the CPPDubovSystem WASM engine
  await DubovSystem.initialize();

  runApp(const MyApp());
}
```

Basic Usage

```dart
// 1. Create a tournament (e.g., 3 total rounds)
final tournament = DubovSystem.createTournament(3);

// 2. Create players (Name, Rating, ID, Initial Points)
final p1 = DubovSystem.createPlayer('Khalil', 2850, 1, 0.0);
final p2 = DubovSystem.createPlayer('Amir', 2790, 2, 0.0);

// 3. Add players to the tournament
tournament.addPlayer(p1);
tournament.addPlayer(p2);

// 4. Set round 1 color logic (true = top seed gets White)
tournament.setRound1Color(true);

// 5. Generate pairings for Round 1
final pairings = tournament.generatePairings(1);

// Iterate through the results
for (var match in pairings) {
  if (match.isBye) {
    print('${match.white.name} receives a BYE');
  } else {
    print('${match.white.name} (White) vs ${match.black.name} (Black)');
  }
}

// 6. Remember to free memory manually when the tournament is completely over
p1.delete();
p2.delete();
tournament.delete();

```

## Technical Details

This package acts as a bridge between the Flutter framework and the CPPDubovSystem C++ library. By using dart:js_interop, it invokes the pairing routines compiled into the dubov.wasm binary, ensuring that the complex logic remains identical to the FIDE-approved source.
