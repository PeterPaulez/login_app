import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.token = '',
    this.expiresIn = 0,
    this.message = '',
    this.statusCode = 200,
    this.duplicatedFields,
  });

  String token;
  int expiresIn;
  String message;
  int statusCode;
  List duplicatedFields;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        expiresIn: json["expiresIn"],
        message: json["message"],
        statusCode: json["statusCode"],
        duplicatedFields: json["duplicatedFields"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiresIn": expiresIn,
        "message": message,
        "statusCode": statusCode,
        "duplicatedFields": duplicatedFields,
      };

  String toString() {
    return 'token: $token\nexpiresIn: ${expiresIn.toString()}\nstatusCode: ${statusCode.toString()}\nmessage: $message\nduplicatedFields: $duplicatedFields';
  }
}
