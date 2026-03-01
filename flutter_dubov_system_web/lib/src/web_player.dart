import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'package:flutter_dubov_system_web/src/dubov_system_interop.dart';

class WebPlayer extends PlatformPlayer {
  late final Player _wasmPlayer;
  final DubovModule _module;

  WebPlayer(this._module) {
    _wasmPlayer = _module.Player.callAsConstructor<Player>();
  }

  WebPlayer.fromJs(this._module, this._wasmPlayer);

  WebPlayer.create(
    this._module,
    String name,
    int rating,
    int id,
    double points,
  ) {
    _wasmPlayer = _module.Player.callAsConstructor(
      name.toJS,
      rating.toJS,
      id.toJS,
      points.toJS,
    );
  }

  @override
  void dispose() {
    _wasmPlayer.delete();
  }

  Player get toJs => _wasmPlayer;

  @override
  // ignore: non_constant_identifier_names
  double get ARO => _wasmPlayer.getARO().toDartDouble;

  @override
  void addColor(Color color) {
    _wasmPlayer.addColor(
      color == Color.white
          ? _module.Color.WHITE
          : color == Color.black
          ? _module.Color.BLACK
          : _module.Color.NO_COLOR,
    );
  }

  @override
  void addOpp(int id) {
    _wasmPlayer.addOpp(id.toJS);
  }

  @override
  void addOppRating(int rating) {
    _wasmPlayer.addOppRating(rating.toJS);
  }

  @override
  void addPairingRestriction(int oppId) {
    _wasmPlayer.addPairingRestriction(oppId.toJS);
  }

  @override
  void addPoints(double points) {
    _wasmPlayer.addPoints(points.toJS);
  }

  @override
  bool canPlayOpp(PlatformPlayer opp) {
    return _wasmPlayer.canPlayOpp((opp as WebPlayer)._wasmPlayer).toDart;
  }

  @override
  bool canUpfloat(int cr) {
    return _wasmPlayer.canUpfloat(cr.toJS).toDart;
  }

  @override
  Color get dueColor {
    final c = _wasmPlayer.getDueColor();
    if (c == _module.Color.WHITE) return Color.white;
    if (c == _module.Color.BLACK) return Color.black;
    return Color.noColor;
  }

  @override
  Color get firstColorPlayed {
    final c = _wasmPlayer.getFirstColorPlayed();
    if (c == _module.Color.WHITE) return Color.white;
    if (c == _module.Color.BLACK) return Color.black;
    return Color.noColor;
  }

  @override
  int getNumUpfloatedIfMaxUpfloater(int totalRounds) {
    return _wasmPlayer
        .getNumUpfloatedIfMaxUpfloater(totalRounds.toJS)
        .toDartInt;
  }

  @override
  bool get hasReceivedBye => _wasmPlayer.hasReceievedBye().toDart;

  @override
  int get id => _wasmPlayer.getID().toDartInt;

  @override
  void incrementUpfloat() {
    _wasmPlayer.incrementUpfloat();
  }

  @override
  bool isColorHistEqual(PlatformPlayer opp) {
    return _wasmPlayer.isColorHistEqual((opp as WebPlayer)._wasmPlayer).toDart;
  }

  @override
  String get name => _wasmPlayer.getName().toDart;

  @override
  int get oppCount => _wasmPlayer.getOppCount().toDartInt;

  @override
  double get points => _wasmPlayer.getPoints().toDartDouble;

  @override
  ColorPreference get preferenceStrength {
    final c = _wasmPlayer.getPreferenceStrength();
    if (c == _module.ColorPreference.ABSOLUTE) return ColorPreference.absolute;
    if (c == _module.ColorPreference.MILD) return ColorPreference.mild;
    if (c == _module.ColorPreference.ALTERNATION) {
      return ColorPreference.alternation;
    }
    return ColorPreference.noPreference;
  }

  @override
  int get rating => _wasmPlayer.getRating().toDartInt;

  @override
  void setByeStatus(bool byeStatus) {
    _wasmPlayer.setByeStatus(byeStatus.toJS);
  }

  @override
  void setUpfloatPrevStatus(bool status) {
    _wasmPlayer.setUpfloatPrevStatus(status.toJS);
  }

  @override
  bool shouldAlternate(PlatformPlayer opp) {
    return _wasmPlayer.shouldAlternate((opp as WebPlayer)._wasmPlayer).toDart;
  }

  @override
  bool get upfloatedPreviously => _wasmPlayer.upfloatedPreviously().toDart;
}
