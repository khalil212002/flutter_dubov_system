
import 'flutter_dubov_system_web_platform_interface.dart';

class FlutterDubovSystemWeb {
  Future<String?> getPlatformVersion() {
    return FlutterDubovSystemWebPlatform.instance.getPlatformVersion();
  }
}
