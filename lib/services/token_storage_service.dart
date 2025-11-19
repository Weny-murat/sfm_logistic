import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static const _userName = 'user_name';
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _userAdiKey = 'user_adi';
  static const _userAdiSoyadiKey = 'user_adi_soyadi';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserName({required String userName}) async {
    await _storage.write(key: _userName, value: userName);
  }

  Future<void> saveTokensAndUser({
    required String accessToken,
    required String refreshToken,
    required int id,
    required String adi,
    required String adiSoyadi,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(key: _userIdKey, value: '$id');
    await _storage.write(key: _userAdiKey, value: adi);
    await _storage.write(key: _userAdiSoyadiKey, value: adiSoyadi);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> getUserName() => _storage.read(key: _userName);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);
  Future<String?> getUserId() => _storage.read(key: _userIdKey);
  Future<String?> getUserAdi() => _storage.read(key: _userAdiKey);
  Future<String?> getUserAdiSoyadi() => _storage.read(key: _userAdiSoyadiKey);

  Future<void> clearAll() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _userIdKey),
      _storage.delete(key: _userAdiKey),
      _storage.delete(key: _userAdiSoyadiKey),
    ]);
  }
}
