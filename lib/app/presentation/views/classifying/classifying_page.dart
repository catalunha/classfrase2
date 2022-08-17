import 'package:classfrase/app/presentation/controllers/classifying/classifying_controller.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/presentation/views/classifying/utils/utils.dart';
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
  // ClassBy classBy = ClassBy.selecao;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificando esta frase'),
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
                    child: Text('Click em partes da frase.'),
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
                      children: buildPhrase(
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
            onPressed: () async {
              if (widget
                  ._classifyingController.selectedPosPhraseList.isNotEmpty) {
                await widget._classifyingController
                    .onMarkCategoryIfAlreadyClassifiedInPos();
                Get.toNamed(Routes.phraseCategoryGroup);
              } else {
                const snackBar = SnackBar(
                  content: Text('Oops. Selecione um trecho da frase.'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
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
          Container(
              color: Colors.black12,
              child: const Center(
                  child: Text('Você pode reordenar as partes já classificadas.',
                      style: TextStyle(fontSize: 12)))),
          Expanded(
            child: Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReorderableListView(
                    onReorder: _onReorder,
                    children: showClassifications(
                      phraseClassifications:
                          widget._classifyingController.phrase.classifications,
                      classOrder:
                          widget._classifyingController.phrase.classOrder,
                      phraseList:
                          widget._classifyingController.phrase.phraseList,
                      onSelectPhrase:
                          widget._classifyingController.onSelectPhrase,
                    ),
                  ),
                )),
          ),
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

  void setStateLocal() {
    setState(() {});
  }
}
