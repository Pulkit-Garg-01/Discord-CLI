import 'dart:io';

import 'package:dicobot/models/server.dart';
import 'package:dicobot/models/users.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

joinServer(
    Database db1,
    StoreRef<String?, String?> user_store1,
    Database db3,
    StoreRef<dynamic, dynamic> serverStore,
    var serverQuery,
    User currUser) async {
  if (currUser.username == "0") {
    print("login first!!");
    return;
  }
  server serverObj = server();
  print("Enter server name:");
  serverObj.serverName = stdin.readLineSync();

  if (await noServerExist(serverObj.serverName, db3, serverStore)) {
    return;
  }
  //function to see if user already in server

  if(await userInServer(serverObj.serverName,db3,serverStore,currUser)){
    print("user already in server!!");
    return;
  }

  print("Enter ur role [amateur/mod]");
  String? userRole = stdin.readLineSync();
  var user_role;
  switch (userRole) {
    case "mod":
      user_role = Role.mod;
      break;

    case "amateur":
      user_role = Role.amateur;
      break;

    default:
      print("Enter valid Role!!");
      return;
  }

  Map userInfo = {
    'name': currUser.username,
    'role': user_role,
  };

  Map<dynamic, dynamic> oldInfo =
      await serverStore.record(serverObj.serverName).get(db3);
  oldInfo=cloneMap(oldInfo);
  oldInfo['mem_list'].add(userInfo);

  await serverStore.record(serverObj.serverName).delete(db3);
  await serverStore.record(serverObj.serverName).put(db3, oldInfo);

  print(
      "User ${currUser.username} successfully registered in ${serverObj.serverName} as ${user_role}");
}
