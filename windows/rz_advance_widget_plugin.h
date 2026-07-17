#ifndef FLUTTER_PLUGIN_RZ_ADVANCE_WIDGET_PLUGIN_H_
#define FLUTTER_PLUGIN_RZ_ADVANCE_WIDGET_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace rz_advance_widget {

class RzAdvanceWidgetPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  RzAdvanceWidgetPlugin();

  virtual ~RzAdvanceWidgetPlugin();

  // Disallow copy and assign.
  RzAdvanceWidgetPlugin(const RzAdvanceWidgetPlugin&) = delete;
  RzAdvanceWidgetPlugin& operator=(const RzAdvanceWidgetPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace rz_advance_widget

#endif  // FLUTTER_PLUGIN_RZ_ADVANCE_WIDGET_PLUGIN_H_
