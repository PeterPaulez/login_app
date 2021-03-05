import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.token,
    this.expiresIn,
  });

  String token;
  int expiresIn;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        expiresIn: json["expiresIn"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiresIn": expiresIn,
      };
}
