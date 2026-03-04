## 1.0.0

### Added

- Exposed missing player evaluation and history methods from the native C++ engine to the Dart platform interface.
- Added getters for opponent history metrics: `ARO` (Average Rating of Opponents) and `oppCount`.
- Added methods to evaluate floating rules: `canUpfloat`, `getNumUpfloatedIfMaxUpfloater`, and `upfloatedPreviously`.
- Added color history evaluation tools: `firstColorPlayed`, `isColorHistEqual`, and `shouldAlternate`.
- Added match eligibility checks: `canPlayOpp` and `hasReceivedBye`.

### Changed

- Updated documentation in README files to clarify that the engine is "FIDE-compliant" rather than "FIDE-approved", accurately reflecting the current certification status of the underlying `CPPDubovSystem` engine.
