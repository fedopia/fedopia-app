//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <app_links_windows/app_links_windows_plugin.h>
#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AppLinksWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AppLinksWindowsPlugin"));
  FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
}
