import 'dart:io';

import 'package:dicobot/models/server.dart';
import 'package:dicobot/models/users.dart';
import 'package:sembast/sembast.dart';

createServer(
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

  if (await serverAlreadyExist(serverObj.serverName, db3, serverStore)) {
    return;
  }
  serverObj.Creator = currUser.username;

  Map serverProp = {
    'chan_list': [],
    'cat_list': [],
    'mem_list': [],
  };
  Map entry = {
    'name': currUser.username,
    'role': "Creator",
  };
  serverProp['mem_list'].add(entry);
  await serverStore.record(serverObj.serverName).put(db3, serverProp);
}
