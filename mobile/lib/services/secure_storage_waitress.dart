import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Handles data related to flutter secure storage
class SecureStorageWaitress {
  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        sharedPreferencesName: 'FlutterSecureStorage',
      );

  /// Add one item - key/value pairs
  Future<void> addOneItem(
          {required String key, required dynamic value}) async =>
      await _storage.write(
        key: key,
        value: value,
        aOptions: _getAndroidOptions(),
      );

  /// Add many items - key/value pairs
  Future<void> addItems({required Map<String, dynamic> items}) async {
    items.forEach((k, v) async => await _storage.write(
          key: k,
          value: v.toString(),
          aOptions: _getAndroidOptions(),
        ));
  }

  /// Get one item
  Future<String?> getItem({required String k}) async =>
      await _storage.read(key: k);

  /// Get all items saved in secure storage
  Future<Map<String, String>> getAll() async => await _storage.readAll(
        aOptions: _getAndroidOptions(),
      );

  /// Delete one item
  Future<void> removeItem({required String k}) async =>
      await _storage.delete(key: k, aOptions: _getAndroidOptions());

  /// Delete all items from secure storage
  Future<void> removeAll() async => await _storage.deleteAll(
        aOptions: _getAndroidOptions(),
      );
}
