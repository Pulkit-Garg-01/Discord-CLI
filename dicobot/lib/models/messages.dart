import 'dart:convert';
import 'dart:io';

String? toJSON(Map<String?,String?> msg){
  String? JSONString = jsonEncode(msg);
  return JSONString;

}

String? toMaptoJSON(String? username,String? msg,DateTime now){
  return toJSON({
      "sender":"${username}", 
      "message": "$msg",
      "Date and Time":"${now}"});
}

Map<String?,dynamic> toMap(json){
  Map<String?,dynamic> map= jsonDecode(json);
  return map;

}


void displayMsg(Map <String?,dynamic> map){
  stdout.write("Date and Time:");
  print(map['Date and Time']);
  stdout.write("Sender:       ");
  print(map['sender']);
  stdout.write("message :     ");
  print(map['message']);

}