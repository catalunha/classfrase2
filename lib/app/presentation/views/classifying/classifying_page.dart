import 'package:classfrase/app/presentation/controllers/classifying/classifying_controller.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/presentation/views/classifying/parts/classification_type.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassifyingPage extends StatefulWidget {
  final ClassifyingController _classifyingController = Get.find();
  final ClassificationService _classificationService = Get.find();

  ClassifyingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClassifyingPage> createState() => _ClassifyingPageState();
}

class _ClassifyingPageState extends State<ClassifyingPage> {
  bool isHorizontal = true;
  ClassBy classBy = ClassBy.selecao;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificando esta frase'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // widget.onSetNullSelectedPhraseAndCategory();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: Text('Selecione partes da frase.'),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'ou clique aqui para selecionar a frase toda.',
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () {
                  widget._classifyingController.onSelectAllPhrase();
                },
              ),
              IconButton(
                tooltip: 'ou clique aqui para limpar toda seleção.',
                icon: const Icon(Icons.highlight_off),
                onPressed: () {
                  widget._classifyingController.onSelectNonePhrase();
                },
              ),
              IconButton(
                tooltip: 'ou clique aqui para inverter seleção.',
                icon: const Icon(Icons.change_circle_outlined),
                onPressed: () {
                  widget._classifyingController.onSelectInversePhrase();
                },
              ),
            ],
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 28, color: Colors.black),
                      children: buildPhrase2(
                        context: context,
                        phraseList:
                            widget._classifyingController.phrase.phraseList,
                        selectedPhrasePosList:
                            widget._classifyingController.selectedPosPhraseList,
                        onSelectPhrase:
                            widget._classifyingController.onSelectPhrase,
                        setState: setStateLocal,
                      ),
                    ),
                  ),
                ),
              )),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.phraseCategoryGroup);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              primary: Colors.orangeAccent,
            ),
            child: const Text(
              'Clique aqui para escolher classificações.',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (classBy == ClassBy.grupo)
                Expanded(
                  child: Container(
                      color: Colors.black12,
                      child: Center(child: Text(ClassBy.grupo.name))),
                ),
              if (classBy == ClassBy.selecao)
                Expanded(
                  child: Container(
                      color: Colors.black12,
                      child: Center(
                          child: Column(
                        children: [
                          Text(ClassBy.selecao.name),
                          const Text('Você pode reordenar esta lista.',
                              style: TextStyle(fontSize: 12))
                        ],
                      ))),
                ),
              IconButton(
                tooltip: ClassBy.selecao.name,
                icon: Icon(ClassBy.selecao.icon),
                onPressed: () {
                  setState(() {
                    classBy = ClassBy.selecao;
                  });
                },
              ),
              IconButton(
                tooltip: ClassBy.grupo.name,
                icon: Icon(ClassBy.grupo.icon),
                onPressed: () {
                  setState(() {
                    classBy = ClassBy.grupo;
                  });
                },
              ),
            ],
          ),
          if (classBy == ClassBy.grupo)
            Expanded(
              child: Obx(() => SingleChildScrollView(
                    child: Column(
                        // children: buildClassifications2(
                        //   context: context,
                        //   groupList: widget._classifyingController.groupList,
                        //   category2: widget
                        //       ._classificationService.classification.category,
                        //   phraseClassifications: widget
                        //       ._classifyingController.phrase.classifications,
                        //   classOrder:
                        //       widget._classifyingController.phrase.classOrder,
                        //   phraseList:
                        //       widget._classifyingController.phrase.phraseList,
                        //   selectedPhrasePosList:
                        //       widget._classifyingController.selectedPosPhraseList,
                        //   onSelectPhrase:
                        //       widget._classifyingController.onSelectPhrase,
                        // ),
                        ),
                  )),
            ),
          // if (classBy == ClassBy.selecao)
          //   Expanded(
          //     child: Obx(() => Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: ReorderableListView(
          //             onReorder: _onReorder,
          //             children: buildClassByLine2(
          //               context: context,
          //               groupList: widget._classifyingController.groupList,
          //               category: widget
          //                   ._classificationService.classification.category,
          //               phraseClassifications: widget
          //                   ._classifyingController.phrase.classifications,
          //               classOrder:
          //                   widget._classifyingController.phrase.classOrder,
          //               phraseList:
          //                   widget._classifyingController.phrase.phraseList,
          //               onSelectPhrase:
          //                   widget._classifyingController.onSelectPhrase,
          //             ),
          //           ),
          //         )),
          //   ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    List<String> classOrderTemp =
        widget._classifyingController.phrase.classOrder;
    String resourceId = classOrderTemp[oldIndex];
    classOrderTemp.removeAt(oldIndex);
    classOrderTemp.insert(newIndex, resourceId);
    widget._classifyingController.onChangeClassOrder(classOrderTemp);
  }

  List<Widget> buildGroup(context) {
    List<Widget> list = [];

    for (var group in widget._classifyingController.groupList) {
      list.add(
        TextButton(
          onPressed: () {
            if (widget
                ._classifyingController.selectedPosPhraseList.isNotEmpty) {
              widget._classifyingController
                  .onUpdateExistCategoryInPos(group.id!);
              widget._classifyingController.onGroupSelected(group.id!);
              // Navigator.pushNamed(context, '/classifications',
              //     arguments: group.id);
            } else {
              const snackBar = SnackBar(
                content: Text('Oops. Selecione um trecho da frase.'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: Text(group.title),
        ),
      );
    }
    print('groups ${list.length}');
    return list;
  }

  void setStateLocal() {
    setState(() {});
  }
}
