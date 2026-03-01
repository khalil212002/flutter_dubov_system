// ignore_for_file: non_constant_identifier_names

import 'dart:js_interop';

@JS()
@anonymous
extension type DubovModuleConfig._(JSObject _) implements JSObject {
  external factory DubovModuleConfig({JSFunction locateFile});
}

@JS()
extension type DubovModule._(JSObject _) implements JSObject {
  external JSFunction get Player;
  external JSFunction get Tournament;

  external ColorEnumObject get Color;
  external ColorPreferenceEnumObject get ColorPreference;
}

@JS()
extension type EmbindEnum._(JSObject _) implements JSObject {
  external JSNumber get value;
}

@JS()
extension type ColorEnumObject._(JSObject _) implements JSObject {
  external EmbindEnum get WHITE;
  external EmbindEnum get BLACK;
  external EmbindEnum get NO_COLOR;
}

@JS()
extension type ColorPreferenceEnumObject._(JSObject _) implements JSObject {
  external EmbindEnum get ABSOLUTE;
  external EmbindEnum get MILD;
  external EmbindEnum get ALTERNATION;
  external EmbindEnum get NO_PREFERENCE;
}

@JS()
extension type JSPlayer._(JSObject _) implements JSObject {
  external JSString getName();
  external JSNumber getRating();
  external JSNumber getID();
  external JSNumber getPoints();
  external EmbindEnum getDueColor();
  external EmbindEnum getPreferenceStrength();
  external JSNumber getARO();
  external JSNumber getOppCount();
  external JSBoolean hasReceievedBye();
  external JSBoolean upfloatedPreviously();
  external EmbindEnum getFirstColorPlayed();
  external JSNumber getNumUpfloatedIfMaxUpfloater(JSNumber totalRounds);
  external void addOpp(JSNumber oppId);
  external void addColor(EmbindEnum color);
  external void addOppRating(JSNumber rating);
  external void incrementUpfloat();
  external void setUpfloatPrevStatus(JSBoolean status);
  external void addPoints(JSNumber points);
  external void setByeStatus(JSBoolean status);
  external void addPairingRestriction(JSNumber oppId);
  external JSBoolean canPlayOpp(JSPlayer opp);
  external JSBoolean canUpfloat(JSNumber cr);
  external JSBoolean shouldAlternate(JSPlayer opp);
  external JSBoolean isColorHistEqual(JSPlayer opp);
  external void delete();
}

@JS()
extension type Match._(JSObject _) implements JSObject {
  external JSPlayer get white;
  external set white(JSPlayer v);
  external JSPlayer get black;
  external set black(JSPlayer v);
  external JSBoolean get is_bye;
  external set is_bye(JSBoolean v);
  external void delete();
}

@JS()
extension type VectorMatch._(JSObject _) implements JSObject {
  external JSNumber size();
  external Match get(JSNumber index);
  external void delete();
}

@JS()
extension type JSTournament._(JSObject _) implements JSObject {
  external void addPlayer(JSPlayer p);
  external void setRound1Color(JSBoolean makeWhite);
  external VectorMatch generatePairings(JSNumber round);
  external VectorMatch generatePairingsBaku(JSNumber round, JSBoolean baku);
  external JSBoolean pairingErrorOccured();
  external void delete();
}
