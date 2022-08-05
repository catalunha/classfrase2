import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/views/phrase/list/parts/phrase_card.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhraseArchivedPage extends StatelessWidget {
  final PhraseController _phraseController = Get.find();

  PhraseArchivedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frases arquivadas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var phrase in _phraseController.phraseArchivedList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: PhraseCard(
          phrase: phrase,
          widgetList: [
            IconButton(
              tooltip: 'Desarquivar esta frase',
              icon: const Icon(AppIconData.outbox),
              onPressed: () => _phraseController.unArchivePhrase(phrase.id!),
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc não tem frases arquivadas.'),
      ));
    }
    return list;
  }
}
