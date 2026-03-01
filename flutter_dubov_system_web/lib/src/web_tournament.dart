import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';
import 'package:flutter_dubov_system_web/src/dubov_system_interop.dart';
import 'package:flutter_dubov_system_web/src/web_player.dart';
import 'web_match.dart' as w;

class WebTournament extends PlatformTournament {
  final DubovModule _module;
  late final Tournament _wasmTournament;

  WebTournament(this._module, int totalRounds) : super(totalRounds) {
    _wasmTournament = _module.Tournament.callAsConstructor(totalRounds.toJS);
  }

  @override
  void dispose() {
    _wasmTournament.delete();
  }

  @override
  void addPlayer(PlatformPlayer p) {
    _wasmTournament.addPlayer((p as WebPlayer).toJs);
  }

  @override
  List<w.Match> generatePairings(int r) {
    final pairings = _wasmTournament.generatePairings(r.toJS);
    final count = pairings.size().toDartInt;
    final List<w.Match> matches = [];
    for (var i in List.generate(count, (i) => i)) {
      final m = pairings.get(i.toJS);
      matches.add(
        w.Match(
          WebPlayer.fromJs(_module, m.white),
          WebPlayer.fromJs(_module, m.black),
          m.is_bye.toDart,
        ),
      );
    }
    return matches;
  }

  @override
  bool pairingErrorOccured() {
    return _wasmTournament.pairingErrorOccured().toDart;
  }

  @override
  void setRound1Color(bool makeWhite) {
    _wasmTournament.setRound1Color(makeWhite.toJS);
  }
}
