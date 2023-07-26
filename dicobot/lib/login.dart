import 'dart:io';
import 'package:sembast/sembast.dart';
//import 'dart:convert';
import 'package:dicobot/models/users.dart';
//import 'package:dicobot/database.dart';
// import 'package:dicobot/register.dart';
 login(Database db1, StoreRef<String?, String?> user_store1, var records,User currUser)async {
  // print(currUser.username);
   if(currUser.username != "0"){
     var a =currUser.username;
     print("user $a already logged in!!");
     return;
   }
 
   
  print("Enter Username : ");
  currUser.username = stdin.readLineSync();
  if(await FindUser(currUser.username, db1, user_store1)==true ){
     print("User must be registered first!!");
     print("Follow the protocoals..");
  }else{
    print("Enter password for ${currUser.username} :");
     currUser.password = stdin.readLineSync();
    var hash_pwd= await user_store1.record(currUser.username).get(db1) as String;
    if(comparePwd(currUser.password!,hash_pwd)){
      //User someUser = new User(username! , password);
      print("User ${currUser.username} logged in successfully!:)");

    }else{
      print("Incorrect password.");
      print("Try Login again!");
    }
  }


}