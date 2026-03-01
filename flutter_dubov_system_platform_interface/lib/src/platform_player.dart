import 'package:flutter_dubov_system_platform_interface/src/platform_color.dart';
import 'package:flutter_dubov_system_platform_interface/src/platform_color_preference.dart';

abstract class Player {
  Player();
  Player.create(String name, int rating, int id, double points);
  String get name;
  int get rating;
  int get id;
  double get points;
  Color get dueColor;
  ColorPreference get preferenceStrength;
  // ignore: non_constant_identifier_names
  double get ARO;
  int get oppCount;
  bool get hasReceivedBye;
  bool get upfloatedPreviously;
  Color get firstColorPlayed;

  void addOpp(int id);
  void addColor(Color color);
  void addOppRating(int rating);
  void incrementUpfloat();
  void setUpfloatPrevStatus(bool status);
  void addPoints(double points);
  void addPairingRestriction(int oppId);
  void setByeStatus(bool byeStatus);
  bool canPlayOpp(Player opp);
  bool canUpfloat(int cr);
  int getNumUpfloatedIfMaxUpfloater(int totalRounds);
  bool shouldAlternate(Player opp);
  bool isColorHistEqual(Player opp);
  void dispose();
}
