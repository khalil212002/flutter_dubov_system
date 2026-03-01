import 'package:flutter_dubov_system_platform_interface/src/platform_player.dart';
import "platform_match.dart";

abstract class PlatformTournament {
  PlatformTournament(int totalRounds);

  void addPlayer(PlatformPlayer p);
  void setRound1Color(bool makeWhite);
  bool pairingErrorOccured();
  List<Match> generatePairings(int r);

  void dispose();
}
