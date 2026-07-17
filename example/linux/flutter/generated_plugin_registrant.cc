//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <rz_advance_widget/rz_advance_widget_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) rz_advance_widget_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RzAdvanceWidgetPlugin");
  rz_advance_widget_plugin_register_with_registrar(rz_advance_widget_registrar);
}
