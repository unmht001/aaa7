import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mytts/mytts.dart';

void main() {
  const MethodChannel channel = MethodChannel('mytts');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Mytts.platformVersion, '42');
  });
}
