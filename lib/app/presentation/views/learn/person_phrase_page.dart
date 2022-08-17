import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:classfrase/app/presentation/services/classification/classification_service.dart';
import 'package:classfrase/app/presentation/views/classifying/utils/utils.dart';
import 'package:classfrase/app/presentation/views/learn/parts/person_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonPhrasePage extends StatefulWidget {
  final LearnController _learnController = Get.find();
  final ClassificationService classificationService = Get.find();

  // final List<String> phraseList;
  // final List<int> selectedPhrasePosList;
  // final List<ClassGroup> groupList;
  // final Map<String, ClassCategory> category;

  // final Map<String, Classification> phraseClassifications;
  // final List<String> classOrder;

  // final PhraseModel phraseCurrent;

  // final Function(int) onSelectPhrase;
  // final VoidCallback onSetNullSelectedPhraseAndCategory;

  PersonPhrasePage({
    Key? key,
    // required this.phraseList,
    // required this.selectedPhrasePosList,
    // required this.groupList,
    // required this.category,
    // required this.phraseClassifications,
    // required this.onSelectPhrase,
    // required this.onSetNullSelectedPhraseAndCategory,
    // required this.phraseCurrent,
    // required this.classOrder,
  }) : super(key: key);

  @override
  State<PersonPhrasePage> createState() => _PersonPhrasePageState();
}

class _PersonPhrasePageState extends State<PersonPhrasePage> {
  // ClassBy classBy = ClassBy.selecao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificação'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // widget.onSetNullSelectedPhraseAndCategory();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          PersonTile(
            community: widget._learnController.person.profile!.community,
            displayName: widget._learnController.person.profile!.name,
            photoURL: widget._learnController.person.profile!.photo,
            email: widget._learnController.person.email,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, color: Colors.black),
                  children: buildPhrase(
                    context: context,
                    phraseList:
                        widget._learnController.personPhrase!.phraseList,
                    selectedPhrasePosList: [],
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    children: showClassifications(
                      phraseClassifications:
                          widget._learnController.personPhrase!.classifications,
                      classOrder:
                          widget._learnController.personPhrase!.classOrder,
                      phraseList:
                          widget._learnController.personPhrase!.phraseList,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
