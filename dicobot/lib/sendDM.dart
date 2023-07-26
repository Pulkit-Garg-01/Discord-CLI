import 'dart:convert';
import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:dicobot/models/users.dart';
import 'package:dicobot/models/messages.dart';


sendDM(Database db1,
        StoreRef<String?, String?> user_store1,
        Database db2,
        StoreRef<String? ,String?> personalStore,
        var dmQuery , 
        User currUser
        )
async {
  
  if(currUser.username=="0"){
    print("login first!!");
    return;
  }

  print("Enter receiver name");
  String? name=stdin.readLineSync();
  if  (await FindUser(name, db1, user_store1)){
    print("enter valid username of receiver");
    return;
  }else{
    print("Enter message");
    String? message=stdin.readLineSync();
    DateTime now = DateTime.now();

    String? msg = toMaptoJSON(currUser.username, message, now);
    
     
     await personalStore.record(name).put(db2,msg);
  }
  
  

 
}