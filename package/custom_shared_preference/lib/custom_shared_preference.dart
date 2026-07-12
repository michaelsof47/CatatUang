import 'custom_shared_preference_platform_interface.dart';

class CustomSharedPreference {
  Future<void> setString(String key, String value) {
    return CustomSharedPreferencePlatform.instance.setString(key, value);
  }

  Future<String?> getString(String key) {
    return CustomSharedPreferencePlatform.instance.getString(key);
  }

  Future<void> setInt(String key, int value) {
    return CustomSharedPreferencePlatform.instance.setInt(key, value);
  }

  Future<int?> getInt(String key) {
    return CustomSharedPreferencePlatform.instance.getInt(key);
  }

  Future<void> setBool(String key, bool value) {
    return CustomSharedPreferencePlatform.instance.setBool(key, value);
  }

  Future<bool?> getBool(String key) {
    return CustomSharedPreferencePlatform.instance.getBool(key);
  }

  Future<void> remove(String key) {
    return CustomSharedPreferencePlatform.instance.remove(key);
  }

  Future<void> clear() {
    return CustomSharedPreferencePlatform.instance.clear();
  }
}
