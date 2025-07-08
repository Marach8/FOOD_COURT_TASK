import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_court/src/config/services/local_storage_service/storage.dart';

final Provider<FCStorageImpl> storageProvider = Provider<FCStorageImpl>(
  (_){
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return FCStorageImpl(secureStorage);
  }
);

class FCStorageImpl implements FCStorage {
  FCStorageImpl(this.prefs);

  final FlutterSecureStorage prefs;

  @override
  Future<void> clear() async => await prefs.deleteAll();

  @override
  Future<String?> get(String key) async => await prefs.read(key: key);

  @override
  Future<void> remove(String key) async => await prefs.delete(key: key);

  @override
  Future<void> set(String key, String? data) async
    => await prefs.write(key: key, value: data.toString());

  @override
  Future<void> setObject<T>(String key, T value) async {
    final String valueString = _encode(value);
    await prefs.write(key: key, value: valueString);
  }

  @override
  Future<T?> getObject<T>(String key) async {
    final String? valueString = await prefs.read(key: key);
    if (valueString != null) {
      return _decode<T>(valueString);
    }
    return null;
  }

  String _encode<T>(T value) {
    if (T == String) {
      return value as String;
    } else if (T == int || T == double || T == bool) {
      return value.toString();
    } else {
      return json.encode(value);
    }
  }

  T _decode<T>(String valueString) {
    if (T is String) {
      return valueString as T;
    } else if (T is int) {
      return int.parse(valueString) as T;
    } else if (T is double) {
      return double.parse(valueString) as T;
    } else if (T is bool) {
      return valueString.toLowerCase() as T;
    } else {
      return json.decode(valueString) as T;
    }
  }
}
