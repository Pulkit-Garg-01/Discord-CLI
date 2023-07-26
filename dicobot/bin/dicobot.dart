import 'package:dicobot/database.dart';
import 'package:dicobot/models/users.dart';
import 'package:dicobot/register.dart';
import 'dart:io';
import 'package:sembast/sembast.dart'; 
// import '../lib/models/users.dart'; 
import 'package:dicobot/login.dart';
import 'package:dicobot/sendDM.dart';
import 'package:dicobot/readDM.dart';
import 'package:dicobot/createserver.dart';
import 'package:dicobot/joinserver.dart';
import 'package:dicobot/addCategory.dart';
import 'package:dicobot/addChannel.dart';

void main (List<String> arguments)async {
User currUser= User("0","0");
User regUser=User("0","0");

var st = databaseFeatures.constructor1();
 List<dynamic> myList = await st.connection();
Database db1 = myList[0];
Database db2 = myList[1];
Database db3 = myList[2];
Database db4 = myList[3];

StoreRef<String?, String?> user_store1 = myList[4];
StoreRef<String? , String?> personalStore = myList[5];
StoreRef<dynamic , dynamic> serverStore = myList[6];
StoreRef<String?, Map> channelStore = myList[7];

var records = myList[8];
var dmQuery = myList[9];
var serverQuery = myList[10];



 bool running = true;
 while (running){
  stdout.write('\n \$\$ ');
  var input = stdin.readLineSync() as String;
  switch(input){
    case "register":
    await register(db1, user_store1, records,regUser);
    break;

    case "login":
    await login(db1, user_store1, records,currUser);
    break;

    case "sendDM":
    await sendDM(db1,user_store1,db2,personalStore,dmQuery,currUser);
    break;

    case "readDM":
    await readDM(db1,user_store1,db2,personalStore,dmQuery,currUser);
    break;

    case "logout":
    print("${currUser.username} logged out successfully!!");
    currUser.username="0";
    break;

    case "create server":
    await createServer(db1,user_store1,db3,serverStore,serverQuery,currUser);
    break;

    case "join server":
    await joinServer(db1,user_store1,db3,serverStore,serverQuery,currUser);
    break;

    case "add category":
    await addCategory(db1,user_store1,db3,serverStore,serverQuery,currUser);
    break;

    case " add channel":
    await addChannel(db1,user_store1,db3,serverStore,serverQuery,currUser,db4,channelStore);

    case "exit":
    print("Thanks for using Discord CLI !!" );
    running=false;
    break;

    default:
        print("\nInvalid input");
        print("Try reading Docs!!");
  }
 }
 await db1.close();
 await db2.close();
 await db3.close();
 await db4.close();
}
