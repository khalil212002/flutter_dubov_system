import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';

/// Represents a pairing between two players in a tournament round.
class MatchPairing {
  /// The player assigned the white pieces.
  final Player white;

  /// The player assigned the black pieces.
  final Player black;

  /// Indicates whether this pairing represents a bye (a player without an opponent).
  bool isBye;

  /// Creates a new [MatchPairing] with the given [white] player, [black] player, and [isBye] status.
  MatchPairing(this.white, this.black, this.isBye);
}
