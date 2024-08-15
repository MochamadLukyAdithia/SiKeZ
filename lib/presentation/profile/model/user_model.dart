import 'dart:convert';

UserProfle userProfleFromJson(String str) =>
    UserProfle.fromJson(json.decode(str));

String userProfleToJson(UserProfle data) => json.encode(data.toJson());

class UserProfle {
  String name;
  String phone;
  int joined;
  String address;

  UserProfle({
    required this.name,
    required this.phone,
    required this.joined,
    required this.address,
  });

  factory UserProfle.fromJson(Map<String, dynamic> json) => UserProfle(
        name: json["name"],
        phone: json["phoneNumber"],
        joined: json["joinedAt"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phone,
        "joinedAt": joined,
        "address": address,
      };
}
