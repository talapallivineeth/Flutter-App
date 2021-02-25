import 'dart:convert';
import 'package:bizwyapp/companies.dart';
import 'package:bizwyapp/main.dart';
import 'package:bizwyapp/profile.dart';
import 'package:bizwyapp/user_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget{
  final String text;
  Dashboard(this.text, {Key key}): super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  UserDb u1;
  SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    List l=widget.text.split(".");
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Logout"),
                onTap: ()async{
                  sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setBool("isloggedin",false);
                  sharedPreferences.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>LoginPage()));
                },
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: Text("${l[1][0].toUpperCase()}${l[1].substring(1)}"),
          leading: new Padding(
            padding: const EdgeInsets.all(9.0),

            child: new Material(
              shape: new CircleBorder(),
            ),
          ),
          backgroundColor: Colors.pink[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ],
        ),

        backgroundColor: Color(0xFFF0F8FF),

        body: Container(
          padding: EdgeInsets.only(top:40.0,left: 10,right: 10,bottom: 30),
          child:GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () async{
                        UserDetails u1;
                        u1=UserDetails(l[0],l[0]);
                        String strJson= json.encode(u1);
                        print(strJson);
                        Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/getUserDetails', strJson);
                        print(res);
                        if(res["error_flag"].toString()=='false'){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>ProfilePage()));
                                      }},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.person_outline,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () async{
                                  UserDetails u1;
                                  u1=UserDetails(l[0],l[0]);
                                  String strJson= json.encode(u1);
                                  print(strJson);
                                  Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/getUserDetails', strJson);
                                  print(res);
                                  if(res["error_flag"].toString()=='false'){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>ProfilePage()));
                                  }
                                },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("My Profile",
                            style : new TextStyle(fontSize: 20.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.local_offer,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("Offers",
                            style : new TextStyle(fontSize: 17.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.calendar_today,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("Reservations",
                            style : new TextStyle(fontSize: 17.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.lightbulb_outline,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("Bizwy Insights",
                            style : new TextStyle(fontSize: 17.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.note,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("My Orders",
                            style : new TextStyle(fontSize: 17.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),
              Card(

                margin: EdgeInsets.only(top:0,right: 4,left: 0,bottom: 6),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.pink[900],
                  child: Center(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 35,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 34,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.add_shopping_cart,size: 44,),
                                color: Colors.pink[900],
                                onPressed: () async{
                                  //Tags t1;
                                  //Catalogue c1;
                                  //UserDb ud;
                                  Com c2;
                                  c2=Com('0','null','10',l[0]);
                                  String strJson= json.encode(c2);
                                  //print(strJson);
                                  Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/listCustomerMappedCompanies', strJson);
                                  //print(res);
                                  if(res["error_flag"].toString()=='false'){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>RecentStores(res['companies'])));
                                  }
                                },
                              ),
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("Place Order",
                            style : new TextStyle(fontSize: 17.0,color: Colors.pink[900])),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        )



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
class Com{
  final String offset;
  final String st;
  final String limit;
  final String ui;

  Com(this.offset,this.st,this.limit,this.ui);
  Map toJson() =>
      {
        'offset':offset,
        'search_tag':st,
        'limit':limit,
        'loggedin_user_id':ui,
      };
}
class UserDetails{
  final String lui;
  final String ui;

  UserDetails(this.lui, this.ui);
  Map toJson() =>
      {
        'loggedin_user_id':lui,
        'user_id':ui,
      };
}
