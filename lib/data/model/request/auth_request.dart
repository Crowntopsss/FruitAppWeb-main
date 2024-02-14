
class AuthRequest {
  AuthRequest({
      String? email, 
      String? password,
    String? firebaseId}){
    _email = email;
    _password = password;
}

  AuthRequest.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }

}