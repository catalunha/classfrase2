import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserProfileModel {
  final String? id;
  final String? photo;
  final String? name;
  final String? description;
  final String? phone;
  final String? community;
  final String? email;
  final List<String>? routes;
  final bool? isActive;
  UserProfileModel({
    this.id,
    this.photo,
    this.name,
    this.description,
    this.phone,
    this.community,
    this.email,
    this.routes,
    this.isActive,
  });

  UserProfileModel copyWith({
    String? id,
    String? photo,
    String? name,
    String? description,
    String? phone,
    String? community,
    String? email,
    List<String>? routes,
    bool? isActive,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      community: community ?? this.community,
      email: email ?? this.email,
      routes: routes ?? this.routes,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photo': photo,
      'name': name,
      'description': description,
      'phone': phone,
      'community': community,
      'email': email,
      'routes': routes,
      'isActive': isActive,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      photo: map['photo'],
      name: map['name'],
      description: map['description'],
      phone: map['phone'],
      community: map['community'],
      email: map['email'],
      routes: List<String>.from(map['routes']),
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, photo: $photo, name: $name, description: $description, phone: $phone, community: $community, email: $email, routes: $routes, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.photo == photo &&
        other.name == name &&
        other.description == description &&
        other.phone == phone &&
        other.community == community &&
        other.email == email &&
        listEquals(other.routes, routes) &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photo.hashCode ^
        name.hashCode ^
        description.hashCode ^
        phone.hashCode ^
        community.hashCode ^
        email.hashCode ^
        routes.hashCode ^
        isActive.hashCode;
  }
}
