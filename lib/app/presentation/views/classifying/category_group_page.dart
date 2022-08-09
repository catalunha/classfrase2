import 'package:classfrase/app/presentation/controllers/classifying/classifying_controller.dart';
import 'package:classfrase/app/presentation/views/classifying/parts/classification_type.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/presentation/views/utils/app_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryGroupPage extends StatelessWidget {
  final ClassifyingController _classifyingController = Get.find();

  // final List<String> phraseList;
  // final List<int> selectedPhrasePosList;
  // final String groupId;
  // final ClassGroup groupData;
  // final List<ClassCategory> categoryList;
  // final Function(String) onSelectCategory;
  // final List<String> selectedCategoryIdList;
  // final VoidCallback onSaveClassification;
  // final VoidCallback onSetNullSelectedCategoryIdOld;

  CategoryGroupPage({
    Key? key,
    // required this.phraseList,
    // required this.selectedPhrasePosList,
    // required this.groupId,
    // required this.groupData,
    // required this.categoryList,
    // required this.onSelectCategory,
    // required this.selectedCategoryIdList,
    // required this.onSaveClassification,
    // required this.onSetNullSelectedCategoryIdOld,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // onSetNullSelectedCategoryIdOld();
            Navigator.pop(context);
          },
        ),
        title: Text(
            '${_classifyingController.categoryList.length} opções em ${_classifyingController.groupSelected.title}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, color: Colors.black),
                  children: buildPhraseNoSelectable(
                    context: context,
                    phraseList: _classifyingController.phrase.phraseList,
                    selectedPhrasePosList:
                        _classifyingController.selectedPosPhraseList,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: const Text('clique para escolher uma ou mais opções.'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() => Column(
                    children: [
                      if (_classifyingController.groupSelected.id ==
                          '720c16e8-f119-44b8-82dd-80ade6e2feae')
                        ...buildCategoriesListNotExpanded(context),
                      if (_classifyingController.groupSelected.id !=
                          '720c16e8-f119-44b8-82dd-80ade6e2feae')
                        ...buildCategoriesListExpanded(context),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () async {
          await _classifyingController.onSaveClassification();
          Get.back();
        },
      ),
    );
  }

  List<Widget> buildCategoriesListNotExpanded(context) {
    List<Widget> list = [];
    List<Widget> listExpansion = [];
    String setCategory = '';

    for (var category in _classifyingController.categoryList) {
      if (category.title.split(' - ').length == 1) {
        if (list.isNotEmpty) {
          listExpansion.add(
            ExpansionTile(
              backgroundColor: Colors.black12,
              title: Text(
                setCategory,
                style: const TextStyle(fontSize: 24),
              ),
              children: list,
            ),
          );
          setCategory = '';
          list = [];
        }
        setCategory = category.title;
      }
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: _classifyingController.selectedCategoryIdList
                        .contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text(category.title),
                  // subtitle: Text(category.id!),
                  onTap: () {
                    _classifyingController.onSelectCategory(category.id!);
                  },
                ),
              ),
            ),
            // AppLink(
            //   url: category.url,
            // ),
          ],
        ),
      );
    }
    if (list.isNotEmpty) {
      listExpansion.add(
        ExpansionTile(
          backgroundColor: Colors.black12,
          title: Text(
            setCategory,
            style: const TextStyle(fontSize: 24),
          ),
          children: list,
        ),
      );
      setCategory = '';
      list = [];
    }
    return listExpansion;
  }

  List<Widget> buildCategoriesListExpanded(context) {
    List<Widget> list = [];
    for (var category in _classifyingController.categoryList) {
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: _classifyingController.selectedCategoryIdList
                        .contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text(category.title),
                  onTap: () {
                    _classifyingController.onSelectCategory(category.id!);
                  },
                ),
              ),
            ),
            AppLink(
              url: category.url,
            ),
          ],
        ),
      );
    }
    return list;
  }
}
