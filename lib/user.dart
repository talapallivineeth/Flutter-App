class User {
  final String mobile;
  final String token;

  User(this.mobile, this.token);
  Map toJson() =>
      {
        'user_mobile':mobile,
        'key_fcm': token,
      };
}