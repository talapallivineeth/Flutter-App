import 'dart:convert';

import 'package:bizwyapp/dashboard.dart';
import 'package:bizwyapp/repository_service.dart';
import 'package:bizwyapp/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class verifyPage extends StatefulWidget{
  final String text;
  verifyPage(this.text, {Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return verifyPageState();
  }
}


class verifyPageState extends State<verifyPage>{
  TextEditingController Textfieldcontroller = TextEditingController();
  final double minimumPadding=5.0;
  final formKey=new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List l=widget.text.split(".");
    return Scaffold(
        body: Form(
          key: formKey,
          child:Container(
            alignment: Alignment.center,
          child:SingleChildScrollView(
          child: Column(
              children:<Widget>[
                      Container(
                          height: 150,
                          child:Center(
                            child:CircleAvatar(
                                radius: 50,
                                backgroundImage:AssetImage('images/bizwyicon.png') ,
                              ),
                      )
                  ),
                Padding(
                    padding:EdgeInsets.only(left: minimumPadding*5,right: minimumPadding*5,top: minimumPadding*5) ,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: Textfieldcontroller,
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        icon: Icon(Icons.lock,color: Colors.pink[900],),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.only(top: 30)),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(

                    onPressed: () async{
                      UserVer u1;
                      SharedPreferences sharedPreferences;
                      bool loggedin;
                      u1=UserVer(l[0],"null",Textfieldcontroller.text);
                      String strJson= json.encode(u1);
                      //print(strJson);
                      Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/checkOTP', strJson);
                      //print(res);
                      //print(res["error_flag"]);
                      if(res["error_flag"].toString()=='false') {
                        final u2=UserDb(res["data"]["user_id"],res["data"]["user_company_id"],l[0],res["data"]["first_name"],res["data"]["last_name"],res["data"]["user_photo"]);
                        if(await RepositoryService.checkUser(res["data"]["user_id"])==0) {
                              await RepositoryService.addUser(u2);
                        }
                        sharedPreferences = await SharedPreferences.getInstance();
                        loggedin=sharedPreferences.getBool("isloggedin");
                        if(loggedin==null || loggedin==false){
                          sharedPreferences.setBool("isloggedin",true);
                        sharedPreferences.setString("user_id",res["data"]["user_id"]);
                          sharedPreferences.setString("fname",res["data"]["first_name"]);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>Dashboard(res["data"]["user_id"]+"."+res["data"]["first_name"])));
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.pink[900],
                    child:Center(
                      child: Text('VERIFY OTP'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(minimumPadding*5),
                alignment: Alignment.bottomRight,
                child:FlatButton(
                    child:Text('Resend OTP',
                      style: TextStyle(color: Colors.pink[900],fontSize: 15,fontWeight: FontWeight.bold,),
                    ),
                    onPressed:() async{
                      await showAlertDialog(context,l);
                    },
                  )),
              ]
          ),
        )
    )));
  }
  Future<void> showAlertDialog(BuildContext context,List l) async{
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No", style: TextStyle(color: Colors.redAccent),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: Colors.redAccent)),
      onPressed: () async {
        UserRe u1;
        u1=UserRe(l[0],l[1]);
        String strJson= json.encode(u1);
        print(strJson);
        Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/checkOTP', strJson);
        print(res);
        print(res["error_flag"]);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Do you want to resend OTP?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<Map<String,dynamic>> fetchLogin(String api, String strJson) async {
    MethodChannel _methodChannel = MethodChannel('flutter/MethodChannelDemo');

    String encryptedDate;
    try {
      encryptedDate = await _methodChannel.invokeMethod(
          "EyncrptionMethod", strJson);
    } on PlatformException catch (e) {
      print("exceptiong");
    }
    var mapping = new Map<String, dynamic>();
    mapping['json_data'] = encryptedDate;
    final http.Response response = await http.post(api,
      body: mapping,
    );
    //print(encryptedDate);
    //print(mapping);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> map = json.decode(response.body);
      //print(map);
      return map;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
class UserVer{
  final String user_id;
  final String token;
  final String otp;

  UserVer(this.user_id, this.token,this.otp);
  Map toJson() =>
      {
        'user_id':user_id,
        'key_fcm': token,
        'otp':otp
      };
}
class UserRe{
  final String user_id;
  final String mobile;

  UserRe(this.user_id, this.mobile);
  Map toJson() =>
      {
        'user_id':user_id,
        'user_mobile':mobile
      };
}