import 'dart:convert';

UserProfle userProfleFromJson(String str) =>
    UserProfle.fromJson(json.decode(str));

String userProfleToJson(UserProfle data) => json.encode(data.toJson());

class UserProfle {
  String name;
  String phone;
  int joined;
  String address;
  String? imageUrl;

  UserProfle(
      {required this.name,
      required this.phone,
      required this.joined,
      required this.address,
      this.imageUrl});

  factory UserProfle.fromJson(Map<String, dynamic> json) => UserProfle(
      name: json["name"],
      phone: json["phoneNumber"],
      joined: json["joinedAt"],
      address: json["address"],
      imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phone,
        "joinedAt": joined,
        "address": address,
        "imageUrl": imageUrl
      };
}
