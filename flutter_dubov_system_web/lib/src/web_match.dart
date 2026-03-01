import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';
import 'package:flutter_dubov_system_web/src/web_player.dart';

class WebMatchPairing extends MatchPairing {
  WebMatchPairing(WebPlayer super.white, WebPlayer super.black, super.isBye);
  @override
  WebPlayer get white => super.white as WebPlayer;
  @override
  Player get black => super.black as WebPlayer;
}
