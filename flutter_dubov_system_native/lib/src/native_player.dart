import 'package:flutter_dubov_system_native/flutter_dubov_system_native_bindings_generated.dart'
    as bindings;
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// Native implementation of [Player] using FFI to communicate with the C++ engine.
class NativePlayer extends Player {
  late final bindings.PlayerHandle _cppPlayer;

  /// Constructs a [NativePlayer] with default values.
  NativePlayer() {
    _cppPlayer = bindings.create_player_default();
  }

  /// Constructs a [NativePlayer] with the given [name], [rating], [id], and [points].
  NativePlayer.create(String name, int rating, int id, double points) {
    Pointer<Utf8> pt = name.toNativeUtf8();
    _cppPlayer = bindings.create_player(pt.cast<Char>(), rating, id, points);
    malloc.free(pt);
  }

  /// The underlying C++ player handle.
  bindings.PlayerHandle get toCpp => _cppPlayer;

  @override
  // ignore: non_constant_identifier_names
  double get ARO => bindings.getARO(_cppPlayer);

  @override
  void addColor(Color color) {
    bindings.ColorHandle ch;
    switch (color) {
      case Color.white:
        ch = bindings.ColorHandle.COLOR_HANDLE_WHITE;
      case Color.black:
        ch = bindings.ColorHandle.COLOR_HANDLE_BLACK;
      case Color.noColor:
        ch = bindings.ColorHandle.COLOR_HANDLE_NO_COLOR;
    }
    bindings.addColor(_cppPlayer, ch);
  }

  @override
  void addOpp(int id) {
    bindings.addOpp(_cppPlayer, id);
  }

  @override
  void addOppRating(int rating) {
    bindings.addOppRating(_cppPlayer, rating);
  }

  @override
  void addPairingRestriction(int oppId) {
    bindings.addPairingRestriction(_cppPlayer, oppId);
  }

  @override
  void addPoints(double points) {
    bindings.addPoints(_cppPlayer, points);
  }

  @override
  bool canPlayOpp(Player opp) {
    return bindings.canPlayOpp(_cppPlayer, (opp as NativePlayer).toCpp);
  }

  @override
  bool canUpfloat(int cr) {
    return bindings.canUpfloat(_cppPlayer, cr);
  }

  @override
  void dispose() {
    bindings.destroy_player(_cppPlayer);
  }

  @override
  Color get dueColor {
    switch (bindings.getDueColor(_cppPlayer)) {
      case bindings.ColorHandle.COLOR_HANDLE_WHITE:
        return Color.white;
      case bindings.ColorHandle.COLOR_HANDLE_BLACK:
        return Color.black;
      case bindings.ColorHandle.COLOR_HANDLE_NO_COLOR:
        return Color.noColor;
    }
  }

  @override
  Color get firstColorPlayed {
    switch (bindings.getFirstColorPlayed(_cppPlayer)) {
      case bindings.ColorHandle.COLOR_HANDLE_WHITE:
        return Color.white;
      case bindings.ColorHandle.COLOR_HANDLE_BLACK:
        return Color.black;
      case bindings.ColorHandle.COLOR_HANDLE_NO_COLOR:
        return Color.noColor;
    }
  }

  @override
  int getNumUpfloatedIfMaxUpfloater(int totalRounds) {
    return bindings.getNumUpfloatedIfMaxUpfloater(_cppPlayer, totalRounds);
  }

  @override
  bool get hasReceivedBye => bindings.hasReceievedBye(_cppPlayer);

  @override
  int get id => bindings.getID(_cppPlayer);

  @override
  void incrementUpfloat() {
    bindings.incrementUpfloat(_cppPlayer);
  }

  @override
  bool isColorHistEqual(Player opp) {
    return bindings.isColorHistEqual(_cppPlayer, (opp as NativePlayer).toCpp);
  }

  @override
  String get name {
    final nameRef = bindings.getName(_cppPlayer);
    try {
      if (nameRef.address == 0) return "";
      return nameRef.cast<Utf8>().toDartString();
    } finally {
      bindings.freeString(nameRef);
    }
  }

  @override
  int get oppCount => bindings.getOppCount(_cppPlayer);

  @override
  double get points => bindings.getPoints(_cppPlayer);

  @override
  ColorPreference get preferenceStrength {
    switch (bindings.getPreferenceStrength(_cppPlayer)) {
      case bindings.ColorPreferenceHandle.COLOR_PREF_NO_PREFERENCE:
        return ColorPreference.noPreference;
      case bindings.ColorPreferenceHandle.COLOR_PREF_MILD:
        return ColorPreference.mild;
      case bindings.ColorPreferenceHandle.COLOR_PREF_ALTERNATION:
        return ColorPreference.alternation;
      case bindings.ColorPreferenceHandle.COLOR_PREF_ABSOLUTE:
        return ColorPreference.absolute;
    }
  }

  @override
  int get rating => bindings.getRating(_cppPlayer);

  @override
  void setByeStatus(bool byeStatus) {
    return bindings.setByeStatus(_cppPlayer, byeStatus);
  }

  @override
  void setUpfloatPrevStatus(bool status) {
    bindings.setUpfloatPrevStatus(_cppPlayer, status);
  }

  @override
  bool shouldAlternate(Player opp) {
    return bindings.shouldAlternate(_cppPlayer, (opp as NativePlayer).toCpp);
  }

  @override
  bool get upfloatedPreviously => bindings.upfloatedPreviously(_cppPlayer);

  @override
  int get numColors => bindings.getNumColors(_cppPlayer);

  @override
  int get numUpfloat => bindings.getNumUpfloat(_cppPlayer);

  @override
  List<int> get oppPlayed {
    final ids = bindings.getOppPlayed(_cppPlayer);
    try {
      if (ids.count == 0 || ids.ptr.address == 0) return [];
      List<int> opps = [];
      for (int i = 0; i < ids.count; i++) {
        opps.add(ids.ptr[i]);
      }
      return opps;
    } finally {
      bindings.freeIntArray(ids);
    }
  }
}
