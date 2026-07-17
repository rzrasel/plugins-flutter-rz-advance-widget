import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rz_advance_widget/rz_advance_widget_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRzAdvanceWidget platform = MethodChannelRzAdvanceWidget();
  const MethodChannel channel = MethodChannel('rz_advance_widget');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
