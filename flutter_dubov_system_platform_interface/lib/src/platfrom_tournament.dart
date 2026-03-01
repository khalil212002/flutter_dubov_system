import 'package:flutter_dubov_system_platform_interface/src/platform_player.dart';
import "platform_match.dart";

/// Represents a tournament managed using the Dubov pairing system.
abstract class Tournament {
  /// Creates a new [Tournament] with the given number of [totalRounds].
  Tournament(int totalRounds);

  /// Adds a [Player] to the tournament.
  void addPlayer(Player p);

  /// Sets the color of the first seeded player in round 1.
  /// If [makeWhite] is true, they play white.
  void setRound1Color(bool makeWhite);

  /// Returns true if a pairing error occurred during the generation process.
  bool pairingErrorOccured();

  /// Generates and returns a list of [MatchPairing] for round [r].
  List<MatchPairing> generatePairings(int r);

  /// Cleans up resources associated with this tournament.
  void dispose();
}
