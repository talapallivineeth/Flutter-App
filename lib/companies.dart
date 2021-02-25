import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RecentStores extends StatefulWidget{
  final a;
    RecentStores(this.a,{Key key}): super(key: key);
  _RecentStoresState createState() =>_RecentStoresState(a);

}
List<List<String>> listof = new List();
//List<> l=new List();
class _RecentStoresState extends State<RecentStores>{
  final res;
  _RecentStoresState(this.res);
  void makeTags() {
    for (int i = 0; i < res.length; i++) {
      listof.add([res[i]['company_name'],res[i]['company_id'],res[i]['branch_id'],res[i]['catalogue_id']]);
    }
    //print(listof);
  }

  @override
  Widget build(BuildContext context)  {
    makeTags();
    return Scaffold(
      appBar: new AppBar(
        title: Text("Recent Stores"),
        leading:GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,

          ),
        ),

        backgroundColor: Colors.pink[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),

        ],
      ),
      body: new Container(
        child: new ListView.builder(
          itemBuilder: (_,int index)=>listDataItem(listof[index]),
          itemCount: listof.length,
        ),
      ),




    );
  }

}
class listDataItem extends StatelessWidget{
  List<String> itemName;
  listDataItem(this.itemName);


  @override
  Widget build(BuildContext context) {
    return new Card(
        elevation: 5.0,
        child:InkWell(
            onTap:() async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String ud=prefs.getString("user_id");
              Tags t1;
              Cat c1;
              t1=Tags(ud,itemName[1],'0','10','null');
              String strJson2= json.encode(t1);
              //print(strJson);
              Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/listCustomTags', strJson2);
              print(res);
              //print(res['tags']);
              //print(a);
              c1=Cat(ud,itemName[2],itemName[3],'','0','10');
              String strJson1= json.encode(c1);
              //print(strJson1);
              Map<String,dynamic> res1=await fetchLogin('http://consumer.bizwy.in/showOwnerCatalogue', strJson1);
              print(res1);

            },

            child:new Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(6.0),
              child: new Row(
                  children:<Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage('images/vegie.jpeg')),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),

                      ),
                    ),

                    new Padding(padding: EdgeInsets.all(8.0)),
                    new Expanded(child:Text(itemName[0],style: TextStyle(fontSize:15.0),))
                  ]
              ),
            )
        )


    );
  }
  Future<Map<String, dynamic>> fetchLogin(String api, String strJson) async {
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
class DataSearch extends SearchDelegate<String> {
  var suggestionlist = [];

  Widget buildCard(BuildContext context, String con) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: 110,
              child: Card(
                  elevation: 5.0,
                  child: InkWell(
                      onTap: () {},

                      child: new Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(6.0),
                        child: new Row(
                            children: <Widget>[
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: AssetImage(
                                      'images/vegie.jpeg')),
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(4.0)),

                                ),
                              ),

                              new Padding(padding: EdgeInsets.all(8.0)),
                              new Expanded(child: Text(
                                con, style: TextStyle(fontSize: 15.0),))
                            ]
                        ),
                      )
                  )


              ));
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,),
      onPressed: () {
        close(context, null);
      },);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionlist =
    query.isEmpty ? [] : listof.where((p) => p[0].toLowerCase().startsWith(query))
        .toList();
    return Column(children: <Widget>[Expanded(child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: suggestionlist.length,
      itemBuilder: (BuildContext context, index) {
        return buildCard(context, suggestionlist[index][0]);
      },
    ))
    ]);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(children: <Widget>[Expanded(child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: suggestionlist.length,
      itemBuilder: (BuildContext context, index) {
        return buildCard(context, suggestionlist[index][0]);
      },
    ))
    ]);
  }

  Future<Map<String, dynamic>> fetchLogin(String api, String strJson) async {
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
class Cat{
  final String ui;
  final String bi;
  final String ci;
  final String st;
  final String offset;
  final String limit;
  Cat(this.ui,this.bi,this.ci,this.st,this.offset,this.limit);
  Map toJson() =>
      {
        'loggedin_user_id':ui,
        'branch_id':bi,
        'catalogue_id':ci,
        'search_string':st,
        'offset':offset,
        'limit':limit
      };
}
class Tags{
  final String ui;
  final String ci;
  final String offset;
  final String limit;
  final String st;

  Tags(this.ui, this.ci,this.offset,this.limit,this.st);
  Map toJson() =>
      {
        'loggedin_user_id':ui,
        'company_id':ci,
        'offset':offset,
        'limit':limit,
        'search_tag':st
      };
}