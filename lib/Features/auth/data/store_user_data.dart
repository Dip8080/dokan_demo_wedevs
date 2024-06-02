import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  final _secureStorage = FlutterSecureStorage();
  Future <void> storeUserData(String token , String email , String userName) async{
    await _secureStorage.write(key: 'token', value: token);
    await _secureStorage.write(key: 'email', value: email);
    await _secureStorage.write(key: 'user', value: userName);
  }

  Future <Map<String , String>> retriveUserData () async{
    String? token = await _secureStorage.read(key: 'token');
    String? email = await _secureStorage.read(key: 'email');
    String? userName = await _secureStorage.read(key: 'user');
    return {'token' : token ?? '', 'email' : email ?? '', 'user' : userName ?? ''};
  }

  Future <void> deleteUserData () async{
    await _secureStorage.delete(key: 'token');
    await _secureStorage.delete(key: 'email');
    await _secureStorage.delete(key: 'user');
  }
}