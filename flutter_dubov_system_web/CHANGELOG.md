## 1.0.2

- **Fixed WASM Memory Leak**: Resolved an issue where player handles were leaked during player listing and pairing generation on the web.
- **Improved Object Identity**: Implemented a `_playerCache` to ensure `Tournament.players` and `MatchPairing` return stable, identical JS-backed Dart objects.
- **Added In-UI Test Runner**: The example app now includes a built-in test runner to verify the integrity and identity of the WASM implementation.

## 1.0.1

- Initial release of the web implementation.
