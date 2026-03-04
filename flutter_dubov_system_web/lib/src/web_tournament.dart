import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';
import 'package:flutter_dubov_system_web/src/dubov_system_interop.dart';
import 'package:flutter_dubov_system_web/src/web_player.dart';

class WebTournament extends Tournament {
  final DubovModule _module;
  late final JSTournament _wasmTournament;

  WebTournament(this._module, int totalRounds) : super(totalRounds) {
    _wasmTournament = _module.Tournament.callAsConstructor(totalRounds.toJS);
  }

  @override
  void dispose() {
    _wasmTournament.delete();
  }

  @override
  void addPlayer(Player p) {
    _wasmTournament.addPlayer((p as WebPlayer).toJs);
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
          matches.add(
            MatchPairing(
              WebPlayer.fromJs(_module, m.white),
              WebPlayer.fromJs(_module, m.black),
              m.is_bye.toDart,
            ),
          );
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
        playerList.add(WebPlayer.fromJs(_module, p));
      }
      return playerList;
    } finally {
      jsPlayers.delete();
    }
  }
}
