import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
export 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart'
    show MatchPairing;

class DubovSystem {
  static Future<void> initialize() {
    return PlatformDubovSystem.instance.initialize();
  }

  static Player createPlayer(String name, int rating, int id, double points) {
    return PlatformDubovSystem.instance.createPlayer(name, rating, id, points);
  }

  static Tournament createTournament(int totalRounds) {
    return PlatformDubovSystem.instance.createTournament(totalRounds);
  }
}
