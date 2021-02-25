import 'dart:convert';
import 'package:bizwyapp/dashboard.dart';
import 'package:bizwyapp/user.dart';
import 'package:bizwyapp/user_register.dart';
import 'package:bizwyapp/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'database_creator.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn=prefs.getBool("isloggedin");
  String uid=prefs.getString("user_id");
  String fn=prefs.getString("fname");
  if(loggedIn==null){
    loggedIn=false;
  }
  //print(loggedIn);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:loggedIn==true? Dashboard(uid+"."+fn):LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    ),

  );
}

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}


class LoginPageState extends State<LoginPage>{
  TextEditingController tfc = TextEditingController();
  final double minimumPadding=5.0;
  final formKey=new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

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
                      controller: tfc,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        icon: Icon(Icons.call,color: Colors.pink[900],),
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.only(top: 30)),

               Container(
                  width:double.infinity,
                  height: 50,
                  child: RaisedButton(

                    onPressed: ()async{
                      User u1;
                      u1=User(tfc.text,"null");
                      String strJson= json.encode(u1);
                      //print(strJson);
                      Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/login', strJson);
                      //print(res);
                      if(res["error_flag"].toString()=='false'){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>verifyPage(res["user_id"]+'.'+tfc.text)));
                      }else{
                          showAlertDialog(context);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.pink[900],
                    child:Center(
                      child: Text('LOGIN'),


                    ),
                  ),
                )
                  ]
          )),
        )
        ));
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel",style: TextStyle(color: Colors.redAccent),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ok",style: TextStyle(color: Colors.redAccent)),
      onPressed:  () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>RegistrationFormScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Mobile Number is not registered.\nPlease do resgistration"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
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

