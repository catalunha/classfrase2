import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:classfrase/app/domain/models/phrase_classification_model.dart';
import 'package:classfrase/app/domain/models/user_model.dart';

class PhraseModel {
  final String? id;
  final UserModel user;
  final String phrase;
  List<String> phraseList;

  final Map<String, Classification> classifications;
  final List<String> classOrder;

  final List<String>? allCategoryList;
  final String folder;
  final String? font;
  final String? diagramUrl;

  final bool isArchived;
  final bool isDeleted;
  final bool isPublic;
  PhraseModel({
    this.id,
    required this.user,
    required this.phrase,
    required this.phraseList,
    required this.classifications,
    required this.classOrder,
    this.isArchived = false,
    this.isDeleted = false,
    this.isPublic = false,
    this.allCategoryList,
    this.font,
    this.diagramUrl,
    this.folder = '/',
  });

  PhraseModel copyWith({
    String? id,
    UserModel? user,
    String? phrase,
    List<String>? phraseList,
    String? folder,
    String? font,
    String? diagramUrl,
    bool? isArchived,
    bool? isPublic,
    bool? isDeleted,
    Map<String, Classification>? classifications,
    List<String>? classOrder,
    List<String>? allCategoryList,
  }) {
    return PhraseModel(
      id: id ?? this.id,
      user: user ?? this.user,
      phrase: phrase ?? this.phrase,
      phraseList: phraseList ?? this.phraseList,
      folder: folder ?? this.folder,
      font: font ?? this.font,
      diagramUrl: diagramUrl ?? diagramUrl,
      isArchived: isArchived ?? this.isArchived,
      classifications: classifications ?? this.classifications,
      allCategoryList: allCategoryList ?? this.allCategoryList,
      classOrder: classOrder ?? this.classOrder,
      isDeleted: isDeleted ?? this.isDeleted,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user.toMap();
    data['phrase'] = phrase;
    data['phraseList'] = phraseList.cast<dynamic>();

    data["classifications"] = <String, dynamic>{};
    for (var item in classifications.entries) {
      data["classifications"][item.key] = item.value.toMap();
    }
    data['classOrder'] = classOrder.cast<dynamic>();
    data['isArchived'] = isArchived;
    data['isDeleted'] = isDeleted;
    data['isPublic'] = isPublic;
    data['folder'] = folder;
    if (font != null) data['font'] = font;
    if (diagramUrl != null) data['diagramUrl'] = diagramUrl;
    return data;
  }

  factory PhraseModel.fromMap(Map<String, dynamic> map) {
    Map<String, Classification>? classifications = <String, Classification>{};
    if (map["classifications"] != null && map["classifications"] is Map) {
      classifications = <String, Classification>{};
      for (var item in map["classifications"].entries) {
        classifications[item.key] = Classification.fromMap(item.value);
      }
    }

    List<String> classOrder = [];
    if (map["classOrder"] == null) {
      for (var item in map["classifications"].entries) {
        classOrder.add(item.key);
      }
    } else {
      classOrder = map['classOrder'].cast<String>();
    }
    var temp = PhraseModel(
      id: map['id'],
      user: UserModel.fromMap(map['user']),
      phrase: map['phrase'],
      classifications: classifications,
      classOrder: classOrder,
      phraseList: map['phraseList'] == null
          ? setPhraseList(map['phrase'])
          : map['phraseList'].cast<String>(),
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
      isPublic: map['isPublic'] ?? false,
      font: map['font'],
      diagramUrl: map['diagramUrl'],
      folder: map['folder'],
    );
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(json.decode(source));

  static List<String> setPhraseList(String phrase) {
    String word = '';
    List<String> phraseList = [];
    for (var i = 0; i < phrase.length; i++) {
      if (phrase[i].contains(RegExp(
          r"[A-Za-záàãâäÁÀÃÂÄéèêëÉÈÊËíìîïÍÌÎÏóòõôöÓÒÕÖÔúùûüÚÙÛÜçÇñÑ0123456789]"))) {
        word += phrase[i];
      } else {
        if (word.isNotEmpty) {
          phraseList.add(word);
          word = '';
        }
        phraseList.add(phrase[i]);
      }
    }
    if (word.isNotEmpty) {
      phraseList.add(word);
      word = '';
    }
    return phraseList;
  }

  static List<String> setAllCategoryList(
      Map<String, Classification> classifications) {
    List<String> allCategoryList = [];
    for (var item in classifications.entries) {
      allCategoryList.addAll(item.value.categoryIdList);
    }
    return allCategoryList;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.id == id &&
        other.user == user &&
        other.phrase == phrase &&
        other.phraseList == phraseList &&
        other.font == font &&
        other.diagramUrl == diagramUrl &&
        other.isArchived == isArchived &&
        other.isPublic == isPublic &&
        other.classOrder == classOrder &&
        other.folder == folder &&
        mapEquals(other.classifications, classifications) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        phrase.hashCode ^
        phraseList.hashCode ^
        font.hashCode ^
        diagramUrl.hashCode ^
        isArchived.hashCode ^
        isPublic.hashCode ^
        folder.hashCode ^
        classOrder.hashCode ^
        classifications.hashCode ^
        isDeleted.hashCode;
  }

  @override
  String toString() {
    return 'PhraseModel(id: $id, user: $user, phrase: $phrase, phraseList: $phraseList, classifications: $classifications, classOrder: $classOrder, allCategoryList: $allCategoryList, folder: $folder, font: $font, diagramUrl: $diagramUrl, isArchived: $isArchived, isDeleted: $isDeleted, isPublic: $isPublic)';
  }
}
