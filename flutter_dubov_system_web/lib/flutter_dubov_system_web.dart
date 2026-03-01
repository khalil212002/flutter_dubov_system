import 'dart:async';
import 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';
import 'package:flutter_dubov_system_web/src/dubov_system_interop.dart';
import 'package:flutter_dubov_system_web/src/web_player.dart';
import 'package:flutter_dubov_system_web/src/web_tournament.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:js_interop';
import 'package:web/web.dart' as web;
export 'package:flutter_dubov_system_platform_interface/flutter_dubov_system_platform_interface.dart';

@JS('DubovSystem')
external JSPromise<DubovModule> _initDubovSystem([DubovModuleConfig config]);

class DubovSystemWeb extends PlatformDubovSystem {
  DubovSystemWeb() : super();

  static void registerWith(Registrar registrar) {
    PlatformDubovSystem.instance = DubovSystemWeb();
  }

  DubovModule? _module;

  @override
  Future<void> initialize() async {
    if (web.document.querySelector('script[src*="dubov.js"]') == null) {
      final dubov =
          web.document.createElement("script") as web.HTMLScriptElement;
      dubov.src =
          "packages/flutter_dubov_system_web/assets/vendor/dubov_system/dubov.js";
      dubov.type = "text/javascript";

      final completer = Completer<void>();
      dubov.onload = ((JSAny? _) {
        completer.complete();
      }).toJS;

      dubov.onerror = ((JSAny? error) {
        completer.completeError("Script load failed: $error");
      }).toJS;

      web.document.head!.appendChild(dubov);
      await completer.future;
    }

    if (_module != null) return;

    JSString customLocateFile(JSString path, JSString prefix) {
      if (path.toDart == 'dubov.wasm') {
        return 'packages/flutter_dubov_system_web/assets/vendor/dubov_system/dubov.wasm'
            .toJS;
      }
      return (prefix.toDart + path.toDart).toJS;
    }

    final config = DubovModuleConfig(locateFile: customLocateFile.toJS);
    final promise = _initDubovSystem(config);
    _module = await promise.toDart;
  }

  @override
  //TODO
  int getMaxUpfloatTimes(int totalRounds) {
    throw UnimplementedError();
  }

  @override
  PlatformPlayer createPlayer(String name, int rating, int id, double points) {
    if (_module.isNull) {
      throw Exception(
        "Dubov System is not initialize. you need to call initialize() first.",
      );
    }
    return WebPlayer.create(_module!, name, rating, id, points);
  }

  @override
  PlatformTournament createTournament(int totalRounds) {
    if (_module.isNull) {
      throw Exception(
        "Dubov System is not initialize. you need to call initialize() first.",
      );
    }
    return WebTournament(_module!, totalRounds);
  }
}
