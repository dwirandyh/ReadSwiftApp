import 'package:flutter/material.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.accessToken,
    required this.tokenType,
  });

  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final String accessToken;
  final String tokenType;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt?.toIso8601String(),
      'accessToken': accessToken,
      'tokenType': tokenType,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['emailVerifiedAt'] != null
          ? DateTime.parse(json['emailVerifiedAt'])
          : null,
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
    );
  }
}
