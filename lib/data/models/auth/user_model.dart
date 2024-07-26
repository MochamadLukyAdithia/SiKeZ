class TokenModel {
  final String message;
  final String token;

  TokenModel({required this.message, required this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      TokenModel(message: json["message"], token: json["token"]);

  Map<String, dynamic> toJson() => {"message": message, "token": token};
}
