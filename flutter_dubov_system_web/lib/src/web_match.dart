import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart' as ds;
import 'package:flutter_dubov_system_web/src/web_player.dart';

class Match extends ds.Match {
  Match(WebPlayer super.white, WebPlayer super.black, super.isBye);
  @override
  WebPlayer get white => super.white as WebPlayer;
  @override
  ds.PlatformPlayer get black => super.black as WebPlayer;
}
