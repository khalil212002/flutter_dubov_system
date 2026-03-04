import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
export 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart'
    show MatchPairing, Color, ColorPreference, Tournament, Player;

/// The main entry point for the Dubov System plugin.
///
/// This class delegates its operations to the platform-specific implementation.
class DubovSystem {
  /// Initializes the Dubov system.
  static Future<void> initialize() {
    return PlatformDubovSystem.instance.initialize();
  }

  /// Creates a new [Player] with the provided [name], [rating], [id], and initial [points].
  static Player createPlayer(String name, int rating, int id, double points) {
    return PlatformDubovSystem.instance.createPlayer(name, rating, id, points);
  }

  /// Creates a new [Tournament] consisting of [totalRounds] rounds.
  static Tournament createTournament(int totalRounds) {
    return PlatformDubovSystem.instance.createTournament(totalRounds);
  }
}
