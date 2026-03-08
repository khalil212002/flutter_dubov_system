import 'package:flutter_dubov_system_platform_interface/src/platform_player.dart';
import 'package:flutter_dubov_system_platform_interface/src/platform_tournament.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
export "src/platform_player.dart";
export "src/platform_color.dart";
export "src/platform_color_preference.dart";
export "src/platform_tournament.dart";
export "src/platform_match.dart";

/// The common platform interface for the Dubov System plugin.
abstract class PlatformDubovSystem extends PlatformInterface {
  /// Constructs a PlatformDubovSystem.
  PlatformDubovSystem() : super(token: _token);

  static final Object _token = Object();
  static PlatformDubovSystem _instance = DefaultDubovSystem(); // Fallback

  /// The default instance of [PlatformDubovSystem] to use.
  static PlatformDubovSystem get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PlatformDubovSystem] when they register themselves.
  static set instance(PlatformDubovSystem instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the platform-specific Dubov system.
  Future<void> initialize();

  /// Creates a platform-specific [Player] with the given [name], [rating], [id], and [points].
  Player createPlayer(String name, int rating, int id, double points);

  /// The static "entry point" that users will call.
  /// It redirects to the platform-specific instance method.
  int getMaxUpfloatTimes(int totalRounds);

  /// Creates a platform-specific [Tournament] with the given number of [totalRounds].
  Tournament createTournament(int totalRounds);
}

/// The default fallback implementation of [PlatformDubovSystem].
///
/// Throws an [UnimplementedError] for all methods until a platform-specific
/// implementation is registered.
class DefaultDubovSystem extends PlatformDubovSystem {
  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  Player createPlayer(String name, int rating, int id, double points) {
    throw UnimplementedError();
  }

  @override
  Tournament createTournament(int totalRounds) {
    throw UnimplementedError();
  }

  @override
  int getMaxUpfloatTimes(int totalRounds) {
    throw UnimplementedError();
  }
}
