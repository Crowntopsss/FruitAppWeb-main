
class AuthResponse<T>{
   String? message;

   bool? success=true;

  AuthResponse({this.message});

  AuthResponse.fromJson(Map<String, dynamic> parsedJson) {
    message = parsedJson['message'];
  }

  Map toJson() {
    Map map = {};
    map["message"] = message;
    return map;
  }

}
