## 1.0.2

- **Fixed Critical Memory Leak**: Resolved an issue where new player objects were created on every call to `getPlayers` or `generatePairingsBaku`, leading to dangling pointers and memory exhaustion.
- **Improved Object Identity**: Implemented a `_playerCache` to ensure that `Tournament.players` returns stable, identical Dart object instances. This prevents redundant allocations and state synchronization issues.

## 1.0.1

- Initial release of the native implementation.
