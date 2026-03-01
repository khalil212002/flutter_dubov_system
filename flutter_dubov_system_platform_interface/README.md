# flutter_dubov_system_platform_interface

The common platform interface for the `flutter_dubov_system` plugin, enabling cross-platform **chess tournament pairings** in Flutter.

This package defines the core contract and cross-platform chess pairing logic built upon the **FIDE-approved CPPDubovSystem engine**. It establishes the foundational classes and methods required to generate official **Swiss system tournament pairings** across different environments, ensuring absolute compliance with international chess rules.

## Features

- Defines the base interface (`PlatformDubovSystem`) for official **Dubov System** chess operations.
- Establishes the contract for managing **chess players, Elo ratings, and tournament rounds**.
- Defines the structure for generating and returning **FIDE-compliant match pairings**.
- Ensures uniform behavior and identical pairing logic rules across all platform implementations (Mobile, Desktop, and Web).

## Usage

This package is **not** intended to be used directly by app developers. It acts as an internal dependency for the federated `flutter_dubov_system` package to enforce a unified API for chess matchmaking.

If you are an app developer looking to add official Dubov Swiss pairings to your Flutter chess application, please depend on the main package: [flutter_dubov_system](https://pub.dev/packages/flutter_dubov_system).

If you are developing a new platform implementation (e.g., for Windows, macOS, Android, or iOS) for `flutter_dubov_system`, your platform-specific package must depend on this package, extend the base classes, and register itself appropriately.
