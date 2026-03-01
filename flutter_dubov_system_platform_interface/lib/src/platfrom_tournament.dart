import 'package:flutter_dubov_system_platform_interface/src/platform_player.dart';
import "platform_match.dart";

abstract class Tournament {
  Tournament(int totalRounds);

  void addPlayer(Player p);
  void setRound1Color(bool makeWhite);
  bool pairingErrorOccured();
  List<Match> generatePairings(int r);

  void dispose();
}
