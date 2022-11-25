import 'package:fedopia/core/data/shared_prefs/base_shared_prefs.dart';

abstract class FedopiaSharedPreferences {
  // set default account
  static Future<bool> setDefaultAccount(String identifier) async {
    return BaseSharedPreferences.setString('default_account', identifier);
  }

  // get default account
  static Future<String?> getDefaultAccountIdentifier() async {
    return BaseSharedPreferences.getString('default_account');
  }
}
