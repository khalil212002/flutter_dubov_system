import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';
import 'package:flutter_dubov_system_web/src/dubov_system_interop.dart';
import 'package:flutter_dubov_system_web/src/web_player.dart';

class WebTournament extends Tournament {
  final DubovModule _module;
  late final JSTournament _wasmTournament;

  /// Cache to map player IDs to Dart WebPlayer objects.
  final Map<int, WebPlayer> _playerCache = {};

  WebTournament(this._module, int totalRounds) : super(totalRounds) {
    _wasmTournament = _module.Tournament.callAsConstructor(totalRounds.toJS);
  }

  @override
  void dispose() {
    _playerCache.clear();
    _wasmTournament.delete();
  }

  @override
  void addPlayer(Player p) {
    final webPlayer = p as WebPlayer;
    _playerCache[webPlayer.id] = webPlayer;
    _wasmTournament.addPlayer(webPlayer.toJs);
  }

  @override
  List<MatchPairing> generatePairings(int r) {
    return generatePairingsBaku(r, false);
  }

  @override
  bool pairingErrorOccured() {
    return _wasmTournament.pairingErrorOccured().toDart;
  }

  @override
  void setRound1Color(bool makeWhite) {
    _wasmTournament.setRound1Color(makeWhite.toJS);
  }

  @override
  List<MatchPairing> generatePairingsBaku(int r, bool bakuAcceleration) {
    final pairings = _wasmTournament.generatePairingsBaku(
      r.toJS,
      bakuAcceleration.toJS,
    );

    try {
      final count = pairings.size().toDartInt;
      final List<MatchPairing> matches = [];

      for (int i = 0; i < count; i++) {
        final m = pairings.get(i.toJS);
        try {
          // Retrieve the original Dart objects from the cache using IDs
          final whiteId = m.white.getID().toDartInt;
          final blackId = m.black.getID().toDartInt;

          final whitePlayer = _playerCache[whiteId]!;
          final blackPlayer = _playerCache[blackId] ?? whitePlayer;

          matches.add(MatchPairing(whitePlayer, blackPlayer, m.is_bye.toDart));
        } finally {
          m.delete();
        }
      }
      return matches;
    } finally {
      pairings.delete();
    }
  }

  @override
  int get playerCount => _wasmTournament.getPlayerCount().toDartInt;

  @override
  List<Player> get players {
    final jsPlayers = _wasmTournament.getPlayers();
    try {
      final count = jsPlayers.size().toDartInt;
      final List<Player> playerList = [];

      for (int i = 0; i < count; i++) {
        final p = jsPlayers.get(i.toJS);
        try {
          final id = p.getID().toDartInt;
          playerList.add(_playerCache[id]!);
        } finally {
          p.delete();
        }
      }
      return playerList;
    } finally {
      jsPlayers.delete();
    }
  }
}
