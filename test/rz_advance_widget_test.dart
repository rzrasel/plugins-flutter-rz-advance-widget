import 'package:flutter_test/flutter_test.dart';
import 'package:rz_advance_widget/rz_advance_widget_platform_interface.dart';
import 'package:rz_advance_widget/rz_advance_widget_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRzAdvanceWidgetPlatform
    with MockPlatformInterfaceMixin
    implements RzAdvanceWidgetPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RzAdvanceWidgetPlatform initialPlatform = RzAdvanceWidgetPlatform.instance;

  test('$MethodChannelRzAdvanceWidget is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRzAdvanceWidget>());
  });

  test('getPlatformVersion', () async {
    //RzAdvanceWidget rzAdvanceWidgetPlugin = RzAdvanceWidget();
    MockRzAdvanceWidgetPlatform fakePlatform = MockRzAdvanceWidgetPlatform();
    RzAdvanceWidgetPlatform.instance = fakePlatform;

    //expect(await rzAdvanceWidgetPlugin.getPlatformVersion(), '42');
  });
}
