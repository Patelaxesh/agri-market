import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String mobile;
  final String role;
  final DateTime createdAt;
  final String? village;
  final String? state;
  final String? businessName;
  final String? city;
  final String? buyerType;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    required this.createdAt,
    this.village,
    this.state,
    this.businessName,
    this.city,
    this.buyerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      if (role == 'farmer') ...{
        'village': village,
        'state': state,
      } else ...{
        'businessName': businessName,
        'city': city,
        'buyerType': buyerType,
      },
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      role: map['role'] ?? 'buyer',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      village: map['village'],
      state: map['state'],
      businessName: map['businessName'],
      city: map['city'],
      buyerType: map['buyerType'],
    );
  }
}