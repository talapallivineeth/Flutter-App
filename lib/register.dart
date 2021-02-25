class Register{
  final String mobile;
  final String f_name;
  final String l_name;
  final String email;
  final String c_code;
  final String u_dob;
  final String u_com;
  final String m_status;
  final String u_gender;
  final String pincode;
  final String city;
  final String state;
  final String country;
  final String add;
  final String area;
  final String gst;
  final String pan;
  Register(this.mobile,this.f_name,this.l_name,this.email,this.c_code,this.u_dob,this.u_com,this.m_status,this.u_gender,this.pincode,this.city,
      this.state,this.country,this.add,this.area,this.gst,this.pan
      );
  Map toJson() =>
      {
        'user_mobile':mobile,
        'first_name':f_name,
        'last_name':l_name,
        'email':email,
        'company_code':c_code,
        'user_dob':u_dob,
        'user_company':u_com,
        'marital_status':m_status,
        'user_gender':u_gender,
        'pincode':pincode,
        'city':city,
        'state':state,
        'country':country,
        'address1':add,
        'area':area,
        'GSTIN':gst,
        'PAN':pan
      };
}
/*u1=Register("7386141272","vineeth","null","null","BZ1234","null","My Shop","null","null","null","null","null","null",
"null","null","null","null");
String strJson= json.encode(u1);
print(strJson);
String api='http://consumer.bizwy.in/userRegistration';
String res=await fetchLogin(api,strJson);
print(res);*/