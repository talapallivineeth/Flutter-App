
import 'package:bizwyapp/database_creator.dart';

class UserDb{
  String user_id;
  String company_id;
  String biz_id;
  String fname;
  String lname;
  String ppic;
  UserDb(this.user_id,this.company_id,this.biz_id,this.fname,this.lname,this.ppic);
  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['user_id']=user_id;
    map['company_id']=company_id;
    map['biz_id']=biz_id;
    map['fname']=fname;
    map['lname']=lname;
    map['ppic']=ppic;
    return map;
  }
  UserDb.fromJson(Map<String, dynamic> json){
      this.user_id=json[DatabaseCreator.user_id];
      this.company_id=json[DatabaseCreator.company_id];
      this.biz_id=json[DatabaseCreator.biz_id];
      this.fname=json[DatabaseCreator.fname];
      this.lname=json[DatabaseCreator.lname];
      this.ppic=json[DatabaseCreator.ppic];
  }
}