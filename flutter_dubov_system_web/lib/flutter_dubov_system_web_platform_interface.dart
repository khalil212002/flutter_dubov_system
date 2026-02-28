import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_dubov_system_web_method_channel.dart';

abstract class FlutterDubovSystemWebPlatform extends PlatformInterface {
  /// Constructs a FlutterDubovSystemWebPlatform.
  FlutterDubovSystemWebPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDubovSystemWebPlatform _instance = MethodChannelFlutterDubovSystemWeb();

  /// The default instance of [FlutterDubovSystemWebPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDubovSystemWeb].
  static FlutterDubovSystemWebPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDubovSystemWebPlatform] when
  /// they register themselves.
  static set instance(FlutterDubovSystemWebPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
