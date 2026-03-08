## 1.0.2

### Fixed

- Resolved significant memory leaks in both Native (FFI) and Web (WASM) implementations.
- Improved object identity: `Tournament.players` and `MatchPairing` now return stable, identical Dart object instances, preventing redundant allocations and state synchronization issues.
- Fixed a spelling error in the platform interface (`platfrom` -> `platform`).

## 1.0.1

### Fixed

- Improved internal memory handling for better stability across all platforms.

## 1.0.0

### Added

- Exposed missing player evaluation and history methods from the native C++ engine to the Dart platform interface.
- Added getters for opponent history metrics: `ARO` (Average Rating of Opponents) and `oppCount`.
- Added methods to evaluate floating rules: `canUpfloat`, `getNumUpfloatedIfMaxUpfloater`, and `upfloatedPreviously`.
- Added color history evaluation tools: `firstColorPlayed`, `isColorHistEqual`, and `shouldAlternate`.
- Added match eligibility checks: `canPlayOpp` and `hasReceivedBye`.

### Changed

- Updated documentation in README files to clarify that the engine is "FIDE-compliant" rather than "FIDE-approved", accurately reflecting the current status of the underlying `CPPDubovSystem` engine.
