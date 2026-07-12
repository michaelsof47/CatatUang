import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_shared_preference_platform_interface.dart';

/// An implementation of [CustomSharedPreferencePlatform] that uses method channels.
class MethodChannelCustomSharedPreference
    extends CustomSharedPreferencePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_shared_preference');

  @override
  Future<void> setString(String key, String value) async {
    await methodChannel.invokeMethod('setString', {'key': key, 'value': value});
  }

  @override
  Future<String?> getString(String key) async {
    return await methodChannel.invokeMethod<String>('getString', {'key': key});
  }

  @override
  Future<void> setInt(String key, int value) async {
    await methodChannel.invokeMethod('setInt', {'key': key, 'value': value});
  }

  @override
  Future<int?> getInt(String key) async {
    return await methodChannel.invokeMethod<int>('getInt', {'key': key});
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await methodChannel.invokeMethod('setBool', {'key': key, 'value': value});
  }

  @override
  Future<bool?> getBool(String key) async {
    return await methodChannel.invokeMethod<bool>('getBool', {'key': key});
  }

  @override
  Future<void> remove(String key) async {
    await methodChannel.invokeMethod('remove', {'key': key});
  }

  @override
  Future<void> clear() async {
    return await methodChannel.invokeMethod('clear');
  }
}
