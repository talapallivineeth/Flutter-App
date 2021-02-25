import 'dart:convert';

import 'package:bizwyapp/register.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class RegistrationFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationFormScreenState();
  }
}

class RegistrationFormScreenState extends State<RegistrationFormScreen> {

  String _phoneNumber;
  String _email=null;
  String _firstname;
  String _lastname=null;
  String _companycode;
  String _GSTIN=null;
  String _PAN=null;
  String _dob=null;
  String _gender=null;
  String _married=null;
  String _pincode=null;
  String _houseno=null;
  String _area=null;
  String _city;
  String _state;
  String _country;
  bool _autovalidate=false;
  Register r1;
  final format = DateFormat("yyyy-MM-dd");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  Widget _buildPhoneNumber() {


    return
      Padding(
          padding:EdgeInsets.only(left:20,right:20,),
          child:TextFormField(

            decoration: InputDecoration(labelText: 'mobile number'),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Phone number is Required';
              }

              return null;
            },
            onSaved: (String value) {
                _phoneNumber=value;
            },

          )

      );
  }


  Widget _buildEmail() {
    return  Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          onSaved: (String value) {
            _email = value;
          },
        )
    );
  }
  Widget _buildFirstName() {
    return
      Padding(
          padding:EdgeInsets.only(left:20,right:20,),
          child:TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'FirstName is Required';
              }

              return null;
            },
            onSaved: (String value) {
              _firstname = value;
            },
          )
      );
  }
  Widget _buildLastName() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
          onSaved: (String value) {
            _lastname = value;
          },
        )
    );
  }
  Widget _buildCompanyCode() {


    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Company Code'),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Company Code is Required';
            }

            return null;
          },
          onSaved: (String value) {
              _companycode=value;
          },
        )
    );
  }
  Widget _buildGSTIN() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),

          onSaved: (String value) {
            _GSTIN = value;
          },
        )
    );
  }
  Widget _buildPAN() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'PAN'),

          onSaved: (String value) {
            _PAN= value;
          },
        )
    );
  }
  Widget _buildDob() {

    return Column(children: <Widget>[
      Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Date of birth'),

        )),
      DateTimeField(
      format: format,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
      },
        onSaved: (date) {
          if(date!=null) {
            _dob = date.toLocal().toString();
          }else{
            _dob=null;
          }
        },
    )
    ]);
  }
  Widget _buildMarried(){

    return new Row(
        children: <Widget>[
          new Radio(
            value: 'S',
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
          new Text(
            'Single',
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(
            value: 'M',
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
          new Text(
            'Married',
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),

        ]
    );

  }
  Widget _buildGender(){
    return new Row(
        children: <Widget>[
          new Radio(
            value: 'M',
            groupValue: _radioValue2,
            onChanged: _handleRadioValueChange2,
          ),
          new Text(
            'Male',
            style: new TextStyle(fontSize: 16.0),
          ),
          new Radio(
            value: 'F',
            groupValue: _radioValue2,
            onChanged: _handleRadioValueChange2,
          ),
          new Text(
            'Female',
            style: new TextStyle(
              fontSize: 16.0,
            ),
          ),
          new Radio(
            value: 'other',
            groupValue: _radioValue2,
            onChanged: _handleRadioValueChange2,
          ),
          new Text(
            'Other',
            style: new TextStyle(fontSize: 16.0),
          ),
        ]

    );

  }
  Widget _buildPincode() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Pincode',
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.pink[900],
                ),
                onPressed: (){},

              )
          ),
          onSaved: (String value) {
            _pincode = value;
          },
        )
    );
  }
  Widget _buildHouseno() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Flatno/houseno/floor/building'),
          onSaved: (String value) {
            _houseno= value;
          },
        ) );
  }
  Widget _buildArea() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Area'),

          onSaved: (String value) {
            _area = value;
          },
        ));
  }
  Widget _buildCity() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'City'),
          onSaved: (String value) {
            _city = value;
          },
        ));
  }
  Widget _buildState() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'State'),

          onSaved: (String value) {
            _state = value;
          },
        )
    );
  }
  Widget _buildCountry() {
    return Padding(
        padding:EdgeInsets.only(left:20,right:20,),
        child:TextFormField(
          decoration: InputDecoration(labelText: 'Country'),

          onSaved: (String value) {
            _country= value;
          },
        )
    );
  }

  String _radioValue1 = 'null';
  String _radioValue2= 'null';


  @override
  Widget build(BuildContext context) {
    //final data =MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up"),
          backgroundColor: Colors.pink[900],
        ),
        body: SingleChildScrollView(
            child:Form(
              key:_formKey,
              autovalidate: _autovalidate,
              child: Column(

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:20),
                  ),
                  Center(
                    child: Stack(children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/profilepic.jpeg'),),
                      Positioned(
                        bottom: 5.0,
                        right: 5.0,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.pink[900],
                            size: 28.0,
                          ),
                        ),

                      ),
                    ]),
                  ),
                  SizedBox(height: 20.0,),
                  _buildPhoneNumber(),
                  _buildEmail(),
                  _buildFirstName(),
                  _buildLastName(),
                  _buildCompanyCode(),
                  _buildGSTIN(),
                  _buildPAN(),
                  _buildDob(),
                  _buildMarried(),
                  _buildGender(),

                  Padding(padding: EdgeInsets.only(top:20)),
                  Row(
                    children:[
                      Container(
                        child: Text('Contact Information',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),),

                      ),


                    ],

                  ),
                  _buildPincode(),
                  _buildHouseno(),
                  _buildArea(),
                  _buildCity(),
                  _buildState(),
                  _buildCountry(),

                  Padding( padding:EdgeInsets.only(top:20,left: 20,right: 20,),
                      child:RaisedButton(
                          onPressed: () async{
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                r1=Register(_phoneNumber,_firstname,_lastname,_email,_companycode,_dob,"My Shop",_married,_gender,_pincode,_city,_state,_country,_houseno,_area,_GSTIN,_PAN);
                                String strJson= json.encode(r1);
                                print(strJson);
                                Map<String,dynamic> res=await fetchLogin('http://consumer.bizwy.in/userRegistration', strJson);
                                print(res);
                                print(res["error_flag"]);
                              }else {
                                //    If all data are not valid then start auto validation.
                                setState(() {
                                  _autovalidate = true;
                                });
                              }
                          },
                          textColor: Colors.white,
                          color: Colors.pink[900],
                          child:Center(
                            child: Text('Sign Up'),
                          )
                      )
                  )
                ],
              ),
            )
        )
    );
  }

  void _handleRadioValueChange1(String value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  void _handleRadioValueChange2(String value) {
    setState(() {
      _radioValue2 = value;
    });
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
    print(encryptedDate);
    print(mapping);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      return map;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}