import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Placeorder extends StatelessWidget {
  final a;
  Placeorder(this.a,{Key key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        CustomLocalizationDelegate(),
      ],
      theme: ThemeData(
          primaryColor: Colors.pink[900],
          accentColor: Colors.pinkAccent
      ),
      debugShowCheckedModeBanner: false,
      home: MyPage(a),
    );
  }
}
class MyPage extends StatefulWidget {
  final a;
  MyPage(this.a,{Key key}): super(key: key);
  @override
  _MyPageState createState() => _MyPageState(a);
}

class Products {
  String name;
  String hotel;
  String price;
  int quantity;
  Products(this.name, this.hotel, this.price,this.quantity);
}
List<Products> all=[Products("Biryani","jewel","Price: 500",0),Products("Biryani","jewel","Price: 500",0),Products("vegBiryani","jewel","Price: 500",0),Products("Biryani","jewel","Price: 500",0),Products("Biryani","jewel","Price: 500",0)];
List<Products> veg=[Products("vegBiryani","jewel","Price: 500",0),Products("vegBiryani","jewel","Price: 500",0)];
List<Products> nonveg=[Products("nonvegBiryani","jewel","Price: 500",0),Products("nonvegBiryani","jewel","Price: 500",0)];
List<Products> belt=[Products("beltBiryani","jewel","Price: 500",0),Products("beltBiryani","jewel","Price: 500",0)];
var pr={'All':all,'Veg':veg,'Non-Veg':nonveg,'Belts':belt,'Shirts':belt};
int ad=0;
//Map<String, bool> values = {'All':false,'Veg': false,'Non-Veg':false,'Belts':false,'Shirts':false};
//List<String> proditems=["All","Veg","Non-Veg","Shirts","Belts"];
String pressed='All';
Color iconcolor=Colors.grey;
class _MyPageState extends State<MyPage>{
  final res;
  _MyPageState(this.res);
  List<String> proditems = new List();
  void makeTags() {
    proditems.add('All');
    for (int i = 0; i < res.length; i++) {
      proditems.add(res[i]['tag_name']);
    }
  }
  var _scaffoldkey=new GlobalKey<ScaffoldState>();
  Widget buildCard(Products con) {
    int a=con.quantity;
    return Container(
        height: 110,
        child:Card(
            elevation: 15.0,
            margin: new EdgeInsets.symmetric(horizontal:5.0, vertical: 2.0),
            child:Stack(children: <Widget>[
              Positioned(
                  top: 15,
                  left: 90,
                  child:Text(con.name,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600),)),
              Positioned(
                  top:35,left:90,child:Text(con.hotel,style: TextStyle(fontSize: 18,color: Colors.black45,fontWeight: FontWeight.w400))),
              Positioned(
                  left:90,bottom: 10,child:Text(con.price,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w400))),
              Positioned(
                  bottom: 10,
                  right: 16,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0) //                 <--- border radius here
                          )
                      ),
                      height: 30,
                      width:90,
                      child: Row(
                          children: <Widget>[
                            if(con.quantity!=0)
                              new SizedBox(
                                  height:30,
                                  width: 25,
                                  child: new FlatButton(
                                    color: Colors.deepOrange,
                                    padding: new EdgeInsets.all(0.0),
                                    child: new Icon(Icons.remove, size: 25.0,color: Colors.white,),
                                    onPressed:(){
                                      setState(() {
                                        con.quantity=con.quantity-1;
                                        ad=ad-1;
                                        a=con.quantity;
                                      });
                                    },
                                  )),
                            con.quantity==0?SizedBox(child:Center(child:Text("Add",style: TextStyle(color: Colors.deepOrange,fontSize: 18),)),width:63,):SizedBox(width:38,child:Center(child:Text("$a",style: TextStyle(color: Colors.deepOrange,fontSize:14)),)),
                            new SizedBox(
                                height:30,
                                width:25,
                                child: new FlatButton(
                                  color: con.quantity!=0? Colors.deepOrange:Colors.black12,
                                  padding: new EdgeInsets.all(0.0),
                                  child: new Icon(Icons.add, size: 25.0,color: con.quantity!=0? Colors.white:Colors.deepOrange),
                                  onPressed:(){
                                    setState(() {
                                      con.quantity=con.quantity+1;
                                      ad=ad+1;
                                      a=con.quantity;
                                    });
                                  },
                                ))
                          ]))),Positioned(
                  child:Container(
                      padding: EdgeInsets.fromLTRB(1,10, 10, 10),
                      child:new Image.asset(
                        'images/admin.jpg',
                        width: 70.0,
                        height: 120.0,
                        fit: BoxFit.cover,
                      )))])));
  }
  Widget rowitem(String p){
    var pflag=0;
    return Row(
      children: <Widget>[
        FlatButton(child:Text("$p",style: TextStyle(fontSize: 14),),onPressed: (){setState(() {
          pressed=p;pflag=1;});},focusColor: Colors.pink[900],splashColor: Colors.pinkAccent,highlightColor: Colors.pink[900],disabledColor: Colors.grey
          ,disabledTextColor: Colors.grey,textColor: pflag==1?Colors.pink[900]:Colors.black,),
        Container(height: 45,child:VerticalDivider(thickness: 1,color: Colors.black,))
      ],
    );
  }

  setSelectedUser(String p) {
    setState(() {
      pressed = p;
      Navigator.of(context).pop();
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets=[];
    widgets.add(Container(color: Colors.pink[900],
        child:ListTile(title: Text("Tags",style: TextStyle(color: Colors.white),),trailing:IconButton(color:Colors.white,icon: Icon(Icons.close),onPressed: ()=>Navigator.of(context).pop()
        ),))
    );
    for (String user in proditems) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: pressed,
          title: Text(user),
          onChanged: (currentUser) {
            //print("Current User $currentUser");
            setSelectedUser(currentUser);
          },
          selected: pressed == user,
          activeColor: Colors.deepOrange,
        ),
      );
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {
    makeTags();
    return Scaffold(
        key: _scaffoldkey,
        endDrawer: Drawer(child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child:Column(
          children:createRadioListUsers(),
          )),),
        appBar: new AppBar(title: Text('Catalouge',textAlign: TextAlign.center,),leading: new IconButton(icon:Icon(Icons.arrow_back),onPressed:(){Navigator.of(context).pop();} ),
            actions: <Widget>[IconButton(icon: Icon(Icons.search),
              onPressed: () {showSearch(context: context, delegate: DataSearch());},
            )],
            bottom: PreferredSize(
                preferredSize:Size(20,20),
                child: Column(
                    children: <Widget>[ Row(
                        children: <Widget>[
                          Text('Hello,Vineeth',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),),
                          Container(width: 115,),
                          Align(
                            alignment: Alignment.topRight,
                            child:Text('$ad|items in cart',style: TextStyle(
                                color: Colors.white,fontSize:18),
                            ),)]),

                    ]))),
        body: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: <Widget>[
                    for(var i in proditems) rowitem(i)
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child:IconButton(onPressed: (){_scaffoldkey.currentState.openEndDrawer();},icon: Icon(Icons.dehaze,size: 18),))
            ]),
            new Expanded(child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: pr[pressed].length,
              itemBuilder: (BuildContext context,index){
                return buildCard(pr[pressed][index]);
              },
            )),
            SizedBox(width:double.infinity,height: 45,child:RaisedButton(child: Text("Next>",style: TextStyle(fontSize: 18),),onPressed: (){},color: Colors.pink[900],))
          ],
        )
    );
  }
}
class DataSearch extends SearchDelegate<String>{
  var suggestionlist=[];
  Widget buildCard(BuildContext context,Products con) {
    int a = con.quantity;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: 110,
              child: Card(
                  elevation: 15.0,
                  margin: new EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 15,
                        left: 90,
                        child: Text(con.name, style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),)),
                    Positioned(
                        top: 35,
                        left: 90,
                        child: Text(con.hotel, style: TextStyle(fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400))),
                    Positioned(
                        left: 90,
                        bottom: 10,
                        child: Text(con.price, style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400))),
                    Positioned(
                        bottom: 10,
                        right: 12,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        5.0) //                 <--- border radius here
                                )
                            ),
                            height: 30,
                            width: 60,
                            child: Row(
                                children: <Widget>[
                                  if(con.quantity != 0)
                                    new SizedBox(
                                        height: 30,
                                        width: 25,
                                        child: new FlatButton(
                                          color: Colors.deepOrange,
                                          padding: new EdgeInsets.all(0.0),
                                          child: new Icon(
                                            Icons.remove, size: 25.0,
                                            color: Colors.white,),
                                          onPressed: () {
                                            setState((){
                                              con.quantity = con.quantity - 1;
                                              ad = ad - 1;
                                              a = con.quantity;});
                                          },
                                        )),
                                  con.quantity == 0
                                      ? Text("Add", style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 18),)
                                      : Text("$a", style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 14)),
                                  new SizedBox(
                                      height: 30,
                                      width: 25,
                                      child: new FlatButton(
                                        color: con.quantity != 0 ? Colors
                                            .deepOrange : Colors.black12,
                                        padding: new EdgeInsets.all(0.0),
                                        child: new Icon(Icons.add, size: 25.0,
                                            color: con.quantity != 0 ? Colors
                                                .white : Colors.deepOrange),
                                        onPressed: () {
                                          setState((){
                                            con.quantity = con.quantity + 1;
                                            ad = ad + 1;
                                            a = con.quantity;});
                                        },
                                      ))
                                ]))), Positioned(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(1, 10, 10, 10),
                            child: new Image.asset(
                              'images/admin.jpg',
                              width: 70.0,
                              height: 120.0,
                              fit: BoxFit.cover,
                            )))
                  ])));
        });
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){query="";},)];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress:transitionAnimation,),onPressed: (){close(context,null);},);
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionlist=query.isEmpty?[]:all.where((p) =>p.name.toLowerCase().startsWith(query)).toList();
    return Column(children:<Widget>[Expanded(child:ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:suggestionlist.length,
      itemBuilder: (BuildContext context,index){
        return buildCard(context,suggestionlist[index]);
      },
    )),
      SizedBox(width:double.infinity,height: 45,child:RaisedButton(child: Text("Next>",style: TextStyle(fontSize: 18),),onPressed: (){},color: Colors.pink[900],))]);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(children:<Widget>[Expanded(child:ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:suggestionlist.length,
      itemBuilder: (BuildContext context,index){
        return buildCard(context,suggestionlist[index]);
      },
    )),
      SizedBox(width:double.infinity,height: 45,child:RaisedButton(child: Text("Next>",style: TextStyle(fontSize: 18),),onPressed: (){},color: Colors.pink[900],))]);
  }
}
class CustomLocalizationDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) => SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(en_US)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "Product Name";
}
