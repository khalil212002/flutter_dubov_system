import 'package:flutter_dubov_system_platform_interface/src/platform_player.dart';
import 'package:flutter_dubov_system_platform_interface/src/platfrom_tournament.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
export "src/platform_player.dart";
export "src/platform_color.dart";
export "src/platform_color_preference.dart";
export "src/platfrom_tournament.dart";
export "src/platform_match.dart";

abstract class PlatformDubovSystem extends PlatformInterface {
  PlatformDubovSystem() : super(token: _token);

  static final Object _token = Object();
  static PlatformDubovSystem _instance = DefaultDubovSystem(); // Fallback

  static PlatformDubovSystem get instance => _instance;

  static set instance(PlatformDubovSystem instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize();
  Player createPlayer(String name, int rating, int id, double points);
  Tournament createTournament(int totalRounds);
}

class DefaultDubovSystem extends PlatformDubovSystem {
  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  int getMaxUpfloatTimes(int totalRounds) {
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
}
