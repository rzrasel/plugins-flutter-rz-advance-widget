import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rz_advance_widget_platform_interface.dart';

/// An implementation of [RzAdvanceWidgetPlatform] that uses method channels.
class MethodChannelRzAdvanceWidget extends RzAdvanceWidgetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rz_advance_widget');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
