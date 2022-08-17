import 'dart:convert';

import 'package:classfrase/app/domain/models/user_model.dart';

class LearnModel {
  final String? id;
  final UserModel user;
  final UserModel person;
  LearnModel({
    this.id,
    required this.user,
    required this.person,
  });

  LearnModel copyWith({
    String? id,
    UserModel? user,
    String? folder,
    UserModel? person,
    bool? isDeleted,
  }) {
    return LearnModel(
      id: id ?? this.id,
      user: user ?? this.user,
      person: person ?? this.person,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'person': person.toMap(),
    };
  }

  factory LearnModel.fromMap(Map<String, dynamic> map) {
    return LearnModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      person: UserModel.fromMap(map['person']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LearnModel.fromJson(String source) =>
      LearnModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LearnModel(id: $id, user: $user, person: $person)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LearnModel &&
        other.id == id &&
        other.user == user &&
        other.person == person;
  }

  @override
  int get hashCode {
    return id.hashCode ^ user.hashCode ^ person.hashCode;
  }
}
