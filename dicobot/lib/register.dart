import 'dart:io';
import 'package:sembast/sembast.dart';
// import 'dart:convert';
// import 'package:crypt/crypt.dart';
import 'package:dicobot/models/users.dart';
// import 'package:dicobot/database.dart';

//import 'package:dicobot/';

register(Database db1, StoreRef<String?, String?> user_store1, var records,
    User currUser) async {
  bool comp = true;

  stdout.write("\nEnter username : ");

  currUser.username = stdin.readLineSync();

  if (await FindUser(currUser.username, db1, user_store1)) {
    while (comp) {
      stdout.write("\nEnter Password : ");
      currUser.password = stdin.readLineSync();

      String? hash1 = hashpwd(currUser.password);
      stdout.write("\nRe-Enter Password : ");
      String? password2 = stdin.readLineSync();
      //  String hash2= hashpwd(password2);
      if (currUser.password == password2) {
        await user_store1.record(currUser.username).put(db1, hash1);

        stdout.write("\nUser registered Successfully!!");

        comp = false;
      } else {
        stdout.write("\npasswords dont match!!!");
      }
    }
  } else {
    print("User already registered. Try using different username!!");
  }
}
