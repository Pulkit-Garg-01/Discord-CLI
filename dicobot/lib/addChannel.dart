import 'dart:io';

import 'package:dicobot/models/server.dart';
import 'package:dicobot/models/users.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';

enum ChannelType { text, voice, announcements }

addChannel(
    Database db1,
    StoreRef<String?, String?> user_store1,
    Database db3,
    StoreRef<dynamic, dynamic> serverStore,
    var serverQuery,
    User currUser,
    Database db4,
    StoreRef<String?, Map> channelStore) async {
  if (currUser.username == "0") {
    print("login first!!");
    return;
  }
  print("Server in which you want to add Channel:");
  String? serverName = stdin.readLineSync();
  if (await noServerExist(serverName, db3, serverStore)) {
    return;
  }
  if (!(await userInServer(serverName, db3, serverStore, currUser))) {
    print("First join the server!!");
    return;
  }
  print(
      "You want to add the channel directly or under some Category[direct/category]");
  String? place = stdin.readLineSync();
   var cat_name;
  switch (place) {
    case "category":
      print('Category in which u want to add channel: ');
      String? cat_name = stdin.readLineSync();
      break;
    case "direct":
      break;
    default:
      print("Invalid Input!!");
      return;
  }
  if (place == "category") {
    if (!(await cat_exist_in_server(cat_name, serverName, db3, serverStore))) {
      print("Category doesnt exist!!");
      return;
    }
  }
  print("Enter Channel name: ");
  String? channelName = stdin.readLineSync();

  var c_record = await channelStore.find(db4);
  for (var rec in c_record) {
    //checking if this is the channel of the correct type and in the correct server  (shannel name making unique in a server)
    if (rec.key == channelName && rec.value['server name'] == serverName) {
      //hence checking if the current user is already in the channel
      for (var user in rec.value['mem_list']) {
        if (user == currUser.username) {
          print("User is already in the channel");
          return;
        }
      }

      // Map po = await channel_store.record(c_name).get(db3) as Map;
      //     po = cloneMap(po); //Create a copy of the map
      //     po['mem_list'].add(c_user1.username);
      //     await channel_store.record(c_name).delete(db3);
      //     await channel_store.record(c_name).put(db3, po);
      //     print("\x1B[32mChannel added successfully\x1B[0m");
      //     return;
    }
  }
  print("Channel Type:[text/voice/announcement]: ");
  String? channelType = stdin.readLineSync();
  switch (channelType) {
    case 'text':
      break;
    case 'voice':
      break;

    case 'announcement':
      break;

    default:
      print("Invalid input");
      return;
  }
  var userRole;
  Map s_record = await serverStore.record(serverName).get(db3);
  for (var a in s_record['mem_list']) {
    if (a['name'] == currUser.username) {
      userRole = a['role'];
    }
  }

  if (userRole == "amateur") {
    print("Only Creator and mod users can create new channels");
    return;
  }
  Map<String, dynamic> Info = {
    'server name': serverName,
    'category name': cat_name,
    'mem_list': [currUser.username],
    'type': channelType,
  };
  await channelStore.record(channelName).put(db4, Info);

  if (place == "direct") {
    Map map = await serverStore.record(serverName).get(db3);
    map = cloneMap(map);
    map['chan_list'].add(channelName);
    await serverStore.record(serverName).delete(db3);
    await serverStore.record(serverName).put(db3, map);
    print('User added to the channel successfully');
  }
  if (place == "category") {
    Map aa = await serverStore.record(serverName).get(db3);

    aa = cloneMap(aa);
    for (var a in aa['cat_list']) {
      if (a['name'] == cat_name) {
        a['chan_list'].add(channelName);
        break;
      }
    }
    await serverStore.record(serverName).delete(db3);
    await serverStore.record(serverName).put(db3, aa);
  }
}
