import 'dart:io';
import 'package:dicobot/models/server.dart';
import 'package:dicobot/models/users.dart';
import 'package:sembast/sembast.dart';

addCategory(
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
  // server serverObj = server();
  stdout.write('Enter server name : ');
  final String? serverName = stdin.readLineSync();

  if (await noServerExist(serverName, db3, serverStore)) {
    return;
  }

  // var serverrec = await serverStore.find(db3);
  for (var query in serverQuery) {
    if (query.key == serverName) {
      for (var mem in query.value['mem_list']) {
        if (mem['name'] == currUser &&
            (mem['role'] == 'mod' || mem['role'] == 'Creator')) {
          stdout.write('Enter category name: ');
          String? catName = stdin.readLineSync();
          Map<String, dynamic> cat = {'name': catName, 'chan_list': []};
          Map<String, dynamic> oldInfo = await serverStore
              .record(serverName)
              .get(db3) as Map<String, dynamic>;
          oldInfo['cat_list'].add(cat);
          Map<String, dynamic> newInfo = oldInfo;
          await serverStore.record(serverName).delete(db3);
          await serverStore.record(serverName).put(db3, newInfo);
          print("category added successfully");
          return;
        } else {
          print(
              "Permission denied!!You need to be an mod or Creator in the server");
        }
      }
    }
  }
}
