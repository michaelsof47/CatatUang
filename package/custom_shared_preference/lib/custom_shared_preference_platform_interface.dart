import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_shared_preference_method_channel.dart';

abstract class CustomSharedPreferencePlatform extends PlatformInterface {
  /// Constructs a CustomSharedPreferencePlatform.
  CustomSharedPreferencePlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomSharedPreferencePlatform _instance =
      MethodChannelCustomSharedPreference();

  /// The default instance of [CustomSharedPreferencePlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomSharedPreference].
  static CustomSharedPreferencePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomSharedPreferencePlatform] when
  /// they register themselves.
  static set instance(CustomSharedPreferencePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setString(String key, String value) {
    throw UnimplementedError('setString() has not implemented.');
  }

  Future<String?> getString(String key) {
    throw UnimplementedError('getString() has not implemented.');
  }

  Future<void> setInt(String key, int value) {
    throw UnimplementedError('setInt() has not implemented.');
  }

  Future<int?> getInt(String key) {
    throw UnimplementedError('getInt() has not implemented.');
  }

  Future<void> setBool(String key, bool value) {
    throw UnimplementedError('setBool() has not implemented.');
  }

  Future<bool?> getBool(String key) {
    throw UnimplementedError('getBool() has not implemented.');
  }

  Future<void> remove(String key) {
    throw UnimplementedError('remove() has not implemented.');
  }

  Future<void> clear() {
    throw UnimplementedError('clear() has not implemented.');
  }
}
