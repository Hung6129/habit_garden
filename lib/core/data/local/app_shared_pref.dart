import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AppSharedPref {
  Future<void> setValue(String key, String value);
  Future<void> deleteValue(String key);
  Future<String> getValue(String key, String defaultValue);
  Future<bool> containsKey(String key);
}

class AppSharedPrefImpl extends AppSharedPref {
  // get storage
  late final _storage = const FlutterSecureStorage();

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'habitgarden@ihun.vn',
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        resetOnError: true,
      );

  @override
  Future<String> getValue(String key, String defaultValue) async {
    final result = await _storage.read(
          key: key,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions(),
        ) ??
        defaultValue;
    return Future.value(result);
  }

  @override
  Future<void> setValue(String key, String value) async {
    await _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
    return Future.value();
  }

  @override
  Future<void> deleteValue(String key) async {
    await _storage.delete(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    return Future.value();
  }

  @override
  Future<bool> containsKey(String key) async {
    final Map<String, String> results = await _storage.readAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
    return results.keys.toList().contains(key);
  }
}
