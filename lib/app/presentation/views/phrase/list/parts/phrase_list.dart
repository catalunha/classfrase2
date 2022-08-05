import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/views/phrase/list/parts/phrase_card.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/presentation/views/utils/app_link.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PhraseList extends StatelessWidget {
  final PhraseController _phraseController = Get.find();

  PhraseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            children: buildPhraseList(context),
          )),
    );
  }

  List<Widget> buildPhraseList(context) {
    List<Widget> list = [];
    print(" phraseList build com ${_phraseController.phraseList.length}");

    for (var phrase in _phraseController.phraseList) {
      list.add(PhraseCard(
        key: ValueKey(phrase),
        phrase: phrase,
        trailing: Wrap(
          spacing: 5,
          children: [
            phrase.isPublic
                ? const Tooltip(
                    message: 'Esta frase é pública.',
                    child: Icon(AppIconData.public))
                : Container(
                    width: 1,
                  ),
          ],
        ),
        widgetList: [
          IconButton(
              tooltip: 'Classificar esta frase',
              icon: const Icon(AppIconData.letter),
              onPressed: () =>
                  Get.toNamed(Routes.phraseClassifying, arguments: phrase)),
          // SizedBox(
          //   width: 50,
          // ),

          // SizedBox(
          //   width: 50,
          // ),
          IconButton(
            tooltip: 'Imprimir a classificação desta frase.',
            icon: const Icon(AppIconData.print),
            onPressed: () async {
              Navigator.pushNamed(
                context,
                '/pdf',
                arguments: phrase.id,
              );
            },
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
          IconButton(
            tooltip: 'Editar esta frase',
            icon: const Icon(AppIconData.edit),
            onPressed: () => _phraseController.edit(phrase.id!),
          ),
        ],
      ));
    }
    print(" list build com ${list.length}");
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc ainda não criou nenhuma frase.'),
      ));
    }
    return list;
  }
}
