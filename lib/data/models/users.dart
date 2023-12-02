import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'users.g.dart';

@HiveType(typeId: 3)
class Users {
  @HiveField(0)
  final int uid;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String? phoneNumber;

  Users({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      uid: map['uid'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber)';
  }
}
