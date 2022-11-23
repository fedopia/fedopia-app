import 'package:flutter/material.dart';

class RouteCodeHandler {
  final RouteSettings settings;
  const RouteCodeHandler({required this.settings});

  Uri getUri() {
    return Uri.parse(settings.name!);
  }

  /// Checks if the RouteSettings contains a code, returns true if so.
  bool hasCode() {
    var uri = Uri.parse(settings.name!);
    final params = uri.queryParameters;
    return uri.toString().contains('/auth') && params.containsKey("code");
  }

  bool hasInstance() {
    var uri = Uri.parse(settings.name!);
    final params = uri.queryParameters;
    return uri.toString().contains('/auth') && params.containsKey("instance");
  }

  /// Returns the code from the route settings
  String? getCode() {
    var uri = Uri.parse(settings.name!);
    if (hasCode()) {
      return uri.queryParameters["code"];
    }
    return null;
  }

  /// Returns the instance from the RouteSettings.
  String? getInstanceHost() {
    var uri = Uri.parse(settings.name!);
    final params = uri.queryParameters;
    return params["instance"];
  }
}
