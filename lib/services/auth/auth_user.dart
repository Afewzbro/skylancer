import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String email;
  final bool isEmailVerified;
  final String name;
  final String surname;
  final String? companyName;
  final String? companyAddress;

  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.name,
    required this.surname,
    this.companyName,
    this.companyAddress,
  });

  factory AuthUser.fromFirebase(User user, {int? role}) {
    final String? companyName = role == 2 ? user.companyName : null;
    final String? companyAddress = role == 2 ? user.companyAddress : null;
    return AuthUser(
      id: user.uid,
      email: user.email!,
      isEmailVerified: user.emailVerified,
      name: user.name,
      surname: user.surname,
      companyName: companyName,
      companyAddress: companyAddress,
    );
  }
}
