import 'package:classfrase/app/domain/models/category_group_model.dart';
import 'package:classfrase/app/domain/models/category_model.dart';
import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum ClassBy { grupo, selecao }

extension ClassByExtension on ClassBy {
  static const names = {
    ClassBy.grupo: 'Classificação por GRUPO.',
    ClassBy.selecao: 'Classificação por SELEÇÃO.',
  };
  String get name => names[this]!;
}

extension ClassByExtensionIcon on ClassBy {
  static const icons = {
    ClassBy.grupo: Icons.view_array_rounded,
    ClassBy.selecao: Icons.view_headline_rounded,
  };
  IconData get icon => icons[this]!;
}

List<Widget> buildClassByLine2({
  required BuildContext context,
  required List<ClassGroup> groupList,
  required Map<String, ClassCategory> category,
  required Map<String, Classification> phraseClassifications,
  required List<String> classOrder,
  required List<String> phraseList,
  Function(int)? onSelectPhrase,
}) {
  List<Widget> lineList = [];

  for (var classId in classOrder) {
    Classification classification = phraseClassifications[classId]!;
    List<int> posPhraseList = classification.posPhraseList;
    List<InlineSpan> listSpan = [];
    for (var i = 0; i < phraseList.length; i++) {
      listSpan.add(TextSpan(
        text: phraseList[i],
        style: phraseList[i] != ' ' && posPhraseList.contains(i)
            ? TextStyle(
                color: Colors.orange.shade900,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              )
            : null,
      ));
    }
    RichText richText = RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 28, color: Colors.black),
        children: listSpan,
      ),
    );

    List<Widget> categoryWidgetList = [];
    for (var group in groupList) {
      List<String> categoryIdList = classification.categoryIdList;
      List<String> categoryTitleList = [];
      for (var id in categoryIdList) {
        if (category.containsKey(id)) {
          if (category[id]!.group.id == group.id) {
            categoryTitleList.add(category[id]!.title);
          }
        }
      }
      if (categoryTitleList.isNotEmpty) {
        categoryWidgetList.add(Text(
          '* ${group.title} *',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ));
        categoryTitleList.sort();
        for (var categoryTitle in categoryTitleList) {
          categoryWidgetList.add(Text(
            categoryTitle,
          ));
        }
      }
    }

    lineList.add(
      Container(
        alignment: Alignment.topCenter,
        key: ValueKey(classId),
        child: Card(
          elevation: 25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GestureDetector(
                    onTap: onSelectPhrase != null
                        ? () {
                            for (var index in posPhraseList) {
                              onSelectPhrase(index);
                            }
                          }
                        : null,
                    child: Row(
                      children: [richText],
                    ),
                  ),
                ),
                ...categoryWidgetList,
              ],
            ),
          ),
        ),
      ),
    );
  }
  return lineList;
}

List<Widget> buildClassifications2({
  required BuildContext context,
  required List<ClassGroup> groupList,
  required Map<String, ClassCategory> category2,
  required Map<String, Classification> phraseClassifications,
  required List<String> classOrder,
  required List<String> phraseList,
  required List<int> selectedPhrasePosList,
  Function(int)? onSelectPhrase,
}) {
  List<Widget> list = [];
  for (var group in groupList) {
    list.add(
      Container(
        width: double.infinity,
        color: Colors.black12,
        child: Center(
          child: Text(group.title),
        ),
      ),
    );
    for (var classId in classOrder) {
      Classification classification = phraseClassifications[classId]!;

      List<int> phrasePosList = classification.posPhraseList;
      String phrase = '';
      for (var pos in phrasePosList) {
        try {
          phrase = '$phrase${phraseList[pos]} ';
        } catch (e) {}
      }
      List<String> phraseCategoryList = classification.categoryIdList;
      List<String> categoryTitleList = [];
      for (var id in phraseCategoryList) {
        if (category2.containsKey(id)) {
          if (category2[id]!.group.id == group.id) {
            categoryTitleList.add(category2[id]!.title);
          }
        }
      }
      categoryTitleList.sort();
      String category = categoryTitleList.join(', ');

      if (category.isNotEmpty) {
        list.add(
          Container(
            color: listEquals(selectedPhrasePosList, phrasePosList)
                ? Colors.yellow
                : null,
            child: ListTile(
              title: Text(phrase),
              subtitle: Text(category),
              onTap: onSelectPhrase != null
                  ? () {
                      for (var index in phrasePosList) {
                        onSelectPhrase(index);
                      }
                    }
                  : null,
            ),
          ),
        );
      }
    }
  }
  list.add(const SizedBox(
    height: 20,
  ));
  return list;
}

List<InlineSpan> buildPhrase2({
  required BuildContext context,
  required List<String> phraseList,
  required List<int> selectedPhrasePosList,
  required Function(int) onSelectPhrase,
  required VoidCallback setState,
}) {
  List<InlineSpan> list = [];
  for (var wordPos = 0; wordPos < phraseList.length; wordPos++) {
    if (phraseList[wordPos] != ' ') {
      list.add(TextSpan(
        text: phraseList[wordPos],
        style: selectedPhrasePosList.contains(wordPos)
            ? TextStyle(
                color: Colors.orange.shade900,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              )
            : null,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            setState();
            onSelectPhrase(wordPos);
          },
      ));
    } else {
      list.add(TextSpan(
        text: phraseList[wordPos],
      ));
    }
  }

  return list;
}

List<InlineSpan> buildPhraseNoSelectable({
  required BuildContext context,
  required List<String> phraseList,
  // required List<int> selectedPhrasePosList,
}) {
  List<InlineSpan> list = [];
  for (var wordPos = 0; wordPos < phraseList.length; wordPos++) {
    if (phraseList[wordPos] != ' ') {
      list.add(TextSpan(
        text: phraseList[wordPos],
        // style: selectedPhrasePosList.contains(wordPos)
        //     ? TextStyle(
        //         color: Colors.orange.shade900,
        //         decoration: TextDecoration.underline,
        //         decorationStyle: TextDecorationStyle.solid,
        //       )
        //     : null,
      ));
    } else {
      list.add(TextSpan(
        text: phraseList[wordPos],
      ));
    }
  }

  return list;
}
