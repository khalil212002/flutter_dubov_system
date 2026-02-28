import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web.dart';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web_platform_interface.dart';
import 'package:flutter_dubov_system_web/flutter_dubov_system_web_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDubovSystemWebPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDubovSystemWebPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDubovSystemWebPlatform initialPlatform = FlutterDubovSystemWebPlatform.instance;

  test('$MethodChannelFlutterDubovSystemWeb is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDubovSystemWeb>());
  });

  test('getPlatformVersion', () async {
    FlutterDubovSystemWeb flutterDubovSystemWebPlugin = FlutterDubovSystemWeb();
    MockFlutterDubovSystemWebPlatform fakePlatform = MockFlutterDubovSystemWebPlatform();
    FlutterDubovSystemWebPlatform.instance = fakePlatform;

    expect(await flutterDubovSystemWebPlugin.getPlatformVersion(), '42');
  });
}
