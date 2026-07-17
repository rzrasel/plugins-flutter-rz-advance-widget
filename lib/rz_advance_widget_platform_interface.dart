import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rz_advance_widget_method_channel.dart';

abstract class RzAdvanceWidgetPlatform extends PlatformInterface {
  /// Constructs a RzAdvanceWidgetPlatform.
  RzAdvanceWidgetPlatform() : super(token: _token);

  static final Object _token = Object();

  static RzAdvanceWidgetPlatform _instance = MethodChannelRzAdvanceWidget();

  /// The default instance of [RzAdvanceWidgetPlatform] to use.
  ///
  /// Defaults to [MethodChannelRzAdvanceWidget].
  static RzAdvanceWidgetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RzAdvanceWidgetPlatform] when
  /// they register themselves.
  static set instance(RzAdvanceWidgetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
