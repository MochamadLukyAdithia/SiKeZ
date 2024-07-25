import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final FlutterSecureStorage flutterSecureStorage;

  TokenService(this.flutterSecureStorage);

  Future<String?> getToken() async =>
      await flutterSecureStorage.read(key: 'token');

  Future<void> saveToken(String token) async =>
      await flutterSecureStorage.write(key: 'token', value: token);

  Future<void> deleteToken() async {
    print("DELETING TOKEN");
    await flutterSecureStorage.delete(key: 'token');
  }
}
