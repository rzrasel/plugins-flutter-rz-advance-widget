#include "include/rz_advance_widget/rz_advance_widget_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "rz_advance_widget_plugin.h"

void RzAdvanceWidgetPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  rz_advance_widget::RzAdvanceWidgetPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
