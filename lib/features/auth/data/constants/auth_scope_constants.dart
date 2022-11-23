class AuthScopeConstants {
  AuthScopeConstants._();

  static const String read = 'read';
  static const String write = 'write';
  static const String follow = 'follow';
  static const String push = 'push';
  static const String all = '$read $write $follow $push';
}
