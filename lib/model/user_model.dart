import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String? name;
  final DateTime? joinedAt;
  final String? address;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.joinedAt,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'joinedAt': joinedAt?.millisecondsSinceEpoch,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    return UserModel(
      id: snapshot.id,
      name: map['name'] != null ? map['name'] as String : null,
      joinedAt: map['joinedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['joinedAt'] as int)
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }
}
