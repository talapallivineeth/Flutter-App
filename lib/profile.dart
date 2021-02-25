import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}
class ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height*.6,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('images/header.png')
                )
            ),
          ),
          SafeArea(
            child:Padding(
              padding: const EdgeInsets.only(top:2),
              child: Column(
                  children: <Widget>[
                    Container(
                      height:20,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: (){

                            },
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top:100,left:20,)),
                        Text('Navya sri',
                          style: TextStyle(color: Colors.white,fontSize: 30,
                          ),
                        )
                      ],
                    )
                  ]
              ),
            ),
          ),


          SafeArea(
            child:Padding(
              padding: const EdgeInsets.only(top:50,left:180),
              child: Column(
                children: <Widget>[

                  Container(
                      height:200,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:AssetImage('images/profilepic.jpeg') ,
                          ),

                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          SafeArea(child:Padding(
              padding: const EdgeInsets.only(top:180,left:210),
              child: MaterialButton(
                onPressed: () {},
                color: Colors.pink[900],
                textColor: Colors.white,
                child: Icon(
                  Icons.camera_alt,
                  size: 22,
                ),
                padding: EdgeInsets.all(5),
                shape: CircleBorder(),
              )
          ),
          ),
          SafeArea(
            child:Padding(padding: EdgeInsets.only(top: 250,left: 25),
              child:Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children:<Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 20,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 19,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.phone),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: <Widget>[
                        Text('Mobile Number',
                          style:TextStyle(
                            color: Colors.grey,
                            fontSize: 15,)),
                            Text('8179499710',
                                style:TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,)),
                      ],
                      ),]),
                      Row(children:<Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 20,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 19,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.mail),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children:<Widget>[
                            SizedBox(
                              width:250,
                        child:Container(
                        child:Text('Email',textAlign: TextAlign.left,
                          style:TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          )))),
                            SizedBox(
                                width:250,
                                child:Container(
                            child:Text('talapallivineeth74@gmail.com',
                              style:TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ))))
                      ],
                      ),]),
                      Row(children:<Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 20,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 19,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.person),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children:<Widget>[
                        Text('Gender,Date of Birth',
                          style:TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          )),
                            Text('Male,YYYY-MM-DD',
                              style:TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ) ,)
                      ],
                      ),]),
                      Row(children:<Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.pink[900],
                            radius: 20,
                            child:CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 19,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.location_on),
                                color: Colors.pink[900],
                                onPressed: () {  },
                              ),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children:<Widget>[
                        Text('Address',
                          style:TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ) ,),
                            Text('Hyderabad',
                              style:TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ) ,)
                      ],
                      ),])
                    ]
                ),),


            ),
          ),
        ],


      ),
    );
  }


}