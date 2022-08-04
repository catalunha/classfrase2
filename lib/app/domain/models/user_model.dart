import 'dart:convert';

import 'package:classfrase/app/domain/models/user_profile_model.dart';

class UserModel {
  final String id;
  final String email;
  UserProfileModel? profile;
  UserModel({
    required this.id,
    required this.email,
    this.profile,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
    UserProfileModel? profile,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'profile': profile?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      profile: UserProfileModel?.fromMap(map['profile']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, email: $email, profile: $profile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
