import 'package:flutter_dubov_system_platform_interface/src/platform_color.dart';
import 'package:flutter_dubov_system_platform_interface/src/platform_color_preference.dart';

/// Represents a participant in a Dubov System tournament.
abstract class Player {
  /// Default constructor for [Player].
  Player();

  /// Creates a [Player] with the given [name], [rating], [id], and [points].
  Player.create(String name, int rating, int id, double points);

  /// The name of the player.
  String get name;

  /// The chess rating of the player.
  int get rating;

  /// The unique identifier of the player.
  int get id;

  /// The current tournament points of the player.
  double get points;

  /// The color the player is due to play in the next round.
  Color get dueColor;

  /// The strength of the player's preference for their due color.
  ColorPreference get preferenceStrength;

  /// The Average Rating of Opponents (ARO).
  // ignore: non_constant_identifier_names
  double get ARO;

  /// The total number of opponents this player has faced.
  int get oppCount;

  /// Indicates whether the player has already received a bye in this tournament.
  bool get hasReceivedBye;

  /// Indicates whether the player was floated up in a previous round.
  bool get upfloatedPreviously;

  /// The color the player was assigned in their first game.
  Color get firstColorPlayed;

  /// Adds an opponent's [id] to this player's history.
  void addOpp(int id);

  /// Records the [color] played by this player in a round.
  void addColor(Color color);

  /// Adds an opponent's [rating] to calculate tie-breaks or ARO.
  void addOppRating(int rating);

  /// Increments the counter tracking how many times the player has been floated up.
  void incrementUpfloat();

  /// Sets whether the player was floated up in the previous round using [status].
  void setUpfloatPrevStatus(bool status);

  /// Adds tournament [points] to the player's score.
  void addPoints(double points);

  /// Restricts the player from being paired with the opponent with [oppId].
  void addPairingRestriction(int oppId);

  /// Sets whether the player has received a bye using [byeStatus].
  void setByeStatus(bool byeStatus);

  /// Returns true if this player is allowed to play the given [opp].
  bool canPlayOpp(Player opp);

  /// Returns true if this player can be floated up in the given score group [cr].
  bool canUpfloat(int cr);

  /// Returns the number of times this player has been upfloated if they are the maximum upfloater for the [totalRounds].
  int getNumUpfloatedIfMaxUpfloater(int totalRounds);

  /// Returns true if this player should alternate colors against [opp].
  bool shouldAlternate(Player opp);

  /// Returns true if this player and [opp] have an equal color history.
  bool isColorHistEqual(Player opp);

  /// Cleans up resources associated with this player.
  void dispose();
}
