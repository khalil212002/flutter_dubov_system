/// Represents a player's preference strength for receiving a specific color in the next round.
enum ColorPreference {
  /// The player must receive their due color.
  absolute,

  /// The player strongly prefers their due color.
  mild,

  /// The player prefers color alternation.
  alternation,

  /// The player has no color preference.
  noPreference,
}
