import 'package:flutter_dubov_system_native/flutter_dubov_system_native_bindings_generated.dart'
    as bindings;
import 'package:flutter_dubov_system_native/src/native_player.dart';
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'dart:ffi';

class NativeTournament extends Tournament {
  late final bindings.TournamentHandle _cppTournament;
  
  /// Cache to map C++ player addresses to Dart NativePlayer objects.
  final Map<int, NativePlayer> _playerCache = {};

  NativeTournament(int totalRounds) : super(totalRounds) {
    _cppTournament = bindings.create_tournament(totalRounds);
  }

  @override
  void addPlayer(Player p) {
    final nativePlayer = p as NativePlayer;
    // Cache the player using its C++ address
    _playerCache[nativePlayer.toCpp.address] = nativePlayer;
    bindings.addPlayer(_cppTournament, nativePlayer.toCpp);
  }

  @override
  void dispose() {
    _playerCache.clear();
    bindings.destroy_tournament(_cppTournament);
  }

  @override
  List<MatchPairing> generatePairings(int r) {
    return generatePairingsBaku(r, false);
  }

  @override
  bool pairingErrorOccured() {
    return bindings.pairingErrorOccured(_cppTournament);
  }

  @override
  void setRound1Color(bool makeWhite) {
    return bindings.setRound1Color(_cppTournament, makeWhite);
  }

  @override
  List<MatchPairing> generatePairingsBaku(int r, bool bakuAcceleration) {
    final bindings.MatchArray matches = bindings.generatePairingsBaku(
      _cppTournament,
      r,
      bakuAcceleration,
    );

    try {
      final List<MatchPairing> pairings = [];
      if (matches.count == 0 || matches.ptr.address == 0) return pairings;

      for (int i = 0; i < matches.count; i++) {
        final bindings.MatchHandle matchStruct = matches.ptr[i];
        
        // Retrieve the original Dart objects from the cache
        final whitePlayer = _playerCache[matchStruct.white.address]!;
        final blackPlayer = matchStruct.black.address != 0 
            ? _playerCache[matchStruct.black.address]! 
            : whitePlayer; // Fallback for byes if needed, though isBye handles it

        pairings.add(
          MatchPairing(whitePlayer, blackPlayer, matchStruct.is_bye),
        );
      }
      return pairings;
    } finally {
      bindings.freeMatchArray(matches);
    }
  }

  @override
  int get playerCount => bindings.getPlayerCount(_cppTournament);

  @override
  List<Player> get players {
    final cppPlayers = bindings.getPlayers(_cppTournament);
    try {
      final List<Player> playerList = [];
      if (cppPlayers.count == 0 || cppPlayers.ptr.address == 0) {
        return playerList;
      }
      for (int i = 0; i < cppPlayers.count; i++) {
        final address = cppPlayers.ptr[i].address;
        playerList.add(_playerCache[address]!);
      }
      return playerList;
    } finally {
      bindings.freePlayerArray(cppPlayers);
    }
  }
}
