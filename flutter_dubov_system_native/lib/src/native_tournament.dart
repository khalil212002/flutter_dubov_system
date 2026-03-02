import 'package:flutter_dubov_system_native/flutter_dubov_system_native_bindings_generated.dart'
    as bindings;
import 'package:flutter_dubov_system_native/src/native_player.dart';
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'dart:ffi';

class NativeTournament extends Tournament {
  late final bindings.TournamentHandle _cppTournament;

  NativeTournament(int totalRounds) : super(totalRounds) {
    _cppTournament = bindings.create_tournament(totalRounds);
  }

  @override
  void addPlayer(Player p) {
    bindings.addPlayer(_cppTournament, (p as NativePlayer).toCpp);
  }

  @override
  void dispose() {
    bindings.destroy_tournament(_cppTournament);
  }

  @override
  List<MatchPairing> generatePairings(int r) {
    final bindings.MatchArray matches = bindings.generatePairings(
      _cppTournament,
      r,
    );
    final List<MatchPairing> pairings = [];

    for (int i = 0; i < matches.count; i++) {
      final bindings.MatchHandle matchStruct = matches.ptr[i];

      final NativePlayer whitePlayer = NativePlayer.fromCpp(matchStruct.white);
      final NativePlayer blackPlayer = NativePlayer.fromCpp(matchStruct.black);

      pairings.add(MatchPairing(whitePlayer, blackPlayer, matchStruct.is_bye));
    }
    bindings.freeMatchArray(matches);
    return pairings;
  }

  @override
  bool pairingErrorOccured() {
    return bindings.pairingErrorOccured(_cppTournament);
  }

  @override
  void setRound1Color(bool makeWhite) {
    return bindings.setRound1Color(_cppTournament, makeWhite);
  }
}
