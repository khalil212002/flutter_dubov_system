import 'package:test/test.dart';

import 'package:flutter_dubov_system_native/flutter_dubov_system_native.dart';

void main() {
  test('invoke native function', () {
    expect(sum(24, 18), 42);
  });

  test('invoke async native callback', () async {
    expect(await sumAsync(24, 18), 42);
  });
}
