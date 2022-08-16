import 'package:classfrase/app/presentation/controllers/classifying/classifying_controller.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/presentation/views/classifying/parts/classification_type.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/presentation/views/utils/app_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class CategoryGroupPage extends StatefulWidget {
  final ClassifyingController _classifyingController = Get.find();
  final ClassificationService _classificationService = Get.find();

  CategoryGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryGroupPage> createState() => _CategoryGroupPageState();
}

class _CategoryGroupPageState extends State<CategoryGroupPage> {
  final TreeController _controller = TreeController(allNodesExpanded: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Escolhendo classificação'),
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
                    phraseList: widget._classifyingController.phrase.phraseList,
                    selectedPhrasePosList:
                        widget._classifyingController.selectedPosPhraseList,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: Colors.black12,
                child: const Text('Escolha uma ou mais opções. '),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                // color: Colors.red,
                width: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(
                      'NGB',
                      style: TextStyle(
                          color: widget._classificationService.selectedNgb
                              ? Colors.green
                              : Colors.black),
                    ),
                    onTap: () {
                      widget._classificationService.categoryFilteredBy('ngb');
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                // color: Colors.red,
                width: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(
                      'CC',
                      style: TextStyle(
                          color: widget._classificationService.selectedNgb
                              ? Colors.black
                              : Colors.green),
                    ),
                    onTap: () {
                      widget._classificationService.categoryFilteredBy('cc');
                      setState(() {});
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                // color: Colors.red,
                width: 30,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.collapseAll();
                    });
                  },
                  icon: Icon(Icons.close_fullscreen_sharp,
                      size: 15,
                      color: _controller.allNodesExpanded
                          ? Colors.black
                          : Colors.green),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                // color: Colors.red,
                width: 30,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.expandAll();
                    });
                  },
                  icon: Icon(Icons.open_in_full,
                      size: 15,
                      color: !_controller.allNodesExpanded
                          ? Colors.black
                          : Colors.green),
                ),
              )
            ],
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(child: buildTree()))),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Obx(() => Column(
          //           children: [
          //             if (_classifyingController.groupSelected.id ==
          //                 '720c16e8-f119-44b8-82dd-80ade6e2feae')
          //               ...buildCategoriesListNotExpanded(context),
          //             if (_classifyingController.groupSelected.id !=
          //                 '720c16e8-f119-44b8-82dd-80ade6e2feae')
          //               ...buildCategoriesListExpanded(context),
          //             const SizedBox(
          //               height: 60,
          //             )
          //           ],
          //         )),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () async {
          await widget._classifyingController.onSaveClassification();
          Get.back();
        },
      ),
    );
  }

  Widget buildTree() {
    List<TreeNode> nodes = widget._classifyingController.createTree();

    return TreeView(
      treeController: _controller,
      nodes: nodes,
    );
  }

  List<Widget> buildCategoriesListNotExpanded(context) {
    List<Widget> list = [];
    List<Widget> listExpansion = [];
    String setCategory = '';

    for (var category in widget._classifyingController.categoryList) {
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
                color: widget._classifyingController.selectedCategoryIdList
                        .contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text(category.title),
                  // subtitle: Text(category.id!),
                  onTap: () {
                    widget._classifyingController
                        .onSelectCategory(category.id!);
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
    for (var category in widget._classifyingController.categoryList) {
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: widget._classifyingController.selectedCategoryIdList
                        .contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text(category.title),
                  onTap: () {
                    widget._classifyingController
                        .onSelectCategory(category.id!);
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
