import 'package:sembast/sembast.dart';
// import 'dart:io';
import 'package:crypt/crypt.dart';

class User {
  String? username = "0";
  String? password = "0";

  User(this.username, this.password);
}

Future<bool> FindUser(String? username, Database db, StoreRef storename) async {
  var record = await storename.find(db);
  for (var rec in record) {
    if (rec.key == username) {
      return false;
    }
  }
  return true;
}

hashpwd(String? pass) {
  return Crypt.sha256(pass!, rounds: 1000).toString();
}

bool comparePwd(String enteredPassword, String hash_pwd) {
  final hashedPwd = Crypt(hash_pwd);
  return hashedPwd.match(enteredPassword);
}
