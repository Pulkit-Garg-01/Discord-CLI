// import 'dart:io';
import 'package:dicobot/models/messages.dart';
import 'package:sembast/sembast.dart';
import 'package:dicobot/models/users.dart';

readDM(
        Database db1,
        StoreRef<String?, String?> user_store1,
        Database db2,
        StoreRef<String? ,String?> personalStore,
        var dmQuery , 
        User currUser
)
async{
   if(currUser.username=="0"){
    print("login first!!");
    return;
  }
// print("received messages!!");
//  var finder =Finder(filter: Filter.byKey(currUser.username));
//  var dms = await personalStore.find(db2,finder: finder);

 for(var dm in dmQuery){
 if(dm.key == currUser.username)
   {Map<String?,dynamic> map = toMap(dm.value);
   displayMsg(map);
   }
   
 }
}