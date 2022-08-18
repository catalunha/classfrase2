import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:classfrase/app/presentation/views/learn/add/learn_add_person.dart';
import 'package:classfrase/app/presentation/views/learn/parts/learn_card.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearnListPage extends StatelessWidget {
  final LearnController _learnController = Get.find();
  // final LearnModel learn;
  // final List<UserRef> learningList;
  // final Function(String) onUserDelete;
  // final Function(String) onSetUserGetPhrases;

  LearnListPage({
    Key? key,
    // required this.learn,
    // required this.onUserDelete,
    // required this.learningList,
    // required this.onSetUserGetPhrases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprendendo com'),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: buildListOfPeople(context),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar uma pessoa.',
        child: const Icon(AppIconData.addInCloud),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => LearnAddPerson());
        },
      ),
    );
  }

  List<Widget> buildListOfPeople(context) {
    List<Widget> list = [];

    for (var learn in _learnController.learnList) {
      list.add(
        Container(
          key: ValueKey(learn),
          child: LearnCard(
            userModel: learn.person,
            widgetList: [
              IconButton(
                tooltip: 'Ver frases desta pessoa.',
                icon: const Icon(AppIconData.list),
                onPressed: () {
                  _learnController.selectedLearn(learn.id!);
                },
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                tooltip: 'Filtrar frases desta pessoa.',
                icon: const Icon(AppIconData.search),
                onPressed: () {
                  // onSetUserGetPhrases(person.id);
                  // Navigator.pushNamed(context, '/learn_phrase_filter',
                  //     arguments: person.id);
                },
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                tooltip: 'Remover esta pessoa do grupo.',
                icon: const Icon(AppIconData.delete),
                onPressed: () {
                  _learnController.onDeleteLearn(learn.id!);
                },
              ),
            ],
          ),
        ),
      );
    }
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Ainda não há pessoas em sua lista.'),
      ));
    }
    return list;
  }
}
