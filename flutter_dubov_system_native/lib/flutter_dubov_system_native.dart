import 'dart:async';

import 'package:flutter_dubov_system_native/src/native_player.dart';
import 'package:flutter_dubov_system_native/src/native_tournament.dart';
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
export 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'package:flutter_dubov_system_native/flutter_dubov_system_native_bindings_generated.dart'
    as bindings;

/// Native implementation of the Dubov System plugin using Dart FFI.
class DubovSystemNative extends PlatformDubovSystem {
  /// Constructs a [DubovSystemNative].
  DubovSystemNative() : super();

  /// Registers this class as the default instance of [PlatformDubovSystem].
  static void registerWith() {
    PlatformDubovSystem.instance = DubovSystemNative();
  }

  @override
  Player createPlayer(String name, int rating, int id, double points) {
    return NativePlayer.create(name, rating, id, points);
  }

  @override
  Tournament createTournament(int totalRounds) {
    return NativeTournament(totalRounds);
  }

  @override
  Future<void> initialize() async {
    return;
  }

  @override
  int getMaxUpfloatTimes(int totalRounds) {
    return bindings.getMaxUpfloatTimes(totalRounds);
  }
}
