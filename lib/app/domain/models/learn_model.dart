import 'dart:convert';

import 'package:classfrase/app/domain/models/user_model.dart';

class LearnModel {
  final String? id;
  final UserModel user;
  final String? folder;
  final UserModel person;
  final bool isDeleted;
  LearnModel({
    this.id,
    required this.user,
    this.folder,
    required this.person,
    this.isDeleted = false,
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
      folder: folder ?? this.folder,
      person: person ?? this.person,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'folder': folder,
      'person': person.toMap(),
      'isDeleted': isDeleted,
    };
  }

  factory LearnModel.fromMap(Map<String, dynamic> map) {
    return LearnModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      folder: map['folder'],
      person: UserModel.fromMap(map['person']),
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory LearnModel.fromJson(String source) =>
      LearnModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LearnModel(id: $id, user: $user, folder: $folder, person: $person, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LearnModel &&
        other.id == id &&
        other.user == user &&
        other.folder == folder &&
        other.person == person &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        folder.hashCode ^
        person.hashCode ^
        isDeleted.hashCode;
  }
}
