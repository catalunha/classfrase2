import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:classfrase/app/presentation/views/learn/parts/learn_phrase_card.dart';
import 'package:classfrase/app/presentation/views/learn/parts/person_tile.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/presentation/views/utils/app_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PersonPhraseListPage extends StatelessWidget {
  final LearnController _learnController = Get.find();

  // final List<PhraseModel> phraseList;
  // final UserRef userRefCurrent;

  PersonPhraseListPage({
    Key? key,
    // required this.phraseList,
    // required this.userRefCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classificações para aprender'),
      ),
      body: Column(
        children: [
          PersonTile(
            displayName: _learnController.person.profile!.name,
            photoURL: _learnController.person.profile!.photo,
            email: _learnController.person.email,
          ),
          Expanded(
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    children: buildItens(context),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var phrase in _learnController.personPhraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: LearnPhraseCard(
          phraseModel: phrase,
          widgetList: [
            IconButton(
              tooltip: 'Ver classificação desta frase.',
              icon: const Icon(AppIconData.letter),
              onPressed: () {
                _learnController.selectPhrase(phrase.id!);
                // Navigator.pushNamed(context, '/learn_phrase',
                //     arguments: phrase.id);
              },
            ),
            // SizedBox(
            //   width: 50,
            // ),
            IconButton(
              tooltip: 'Imprimir a classificação desta frase.',
              onPressed: () => Navigator.pushNamed(
                context,
                '/pdf_learn',
                arguments: phrase.id,
              ),
              icon: const Icon(Icons.print),
            ),
            AppLink(
              url: phrase.diagramUrl,
              icon: AppIconData.diagram,
              tooltipMsg: 'Ver diagrama desta frase',
            ),
            IconButton(
              tooltip: 'Copiar a frase para área de transferência.',
              icon: const Icon(AppIconData.copy),
              onPressed: () {
                Future<void> _copyToClipboard() async {
                  await Clipboard.setData(ClipboardData(text: phrase.phrase));
                }

                _copyToClipboard();
                const snackBar =
                    SnackBar(content: Text('Ok. A frase foi copiada.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Esta pessoa não tem frases públicas.'),
      ));
    }
    return list;
  }
}
