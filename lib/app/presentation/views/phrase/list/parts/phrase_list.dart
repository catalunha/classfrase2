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
      child: Obx(
        () => Column(
          children: _phraseController.isSortedByFolder.value
              ? buildPhraseListOrderedByFolder(context)
              : buildPhraseListOrderedByAlpha(context),
        ),
      ),
    );
    // return SingleChildScrollView(
    //   child: Obx(() => Column(
    //         children: buildPhraseList(context),
    //       )),
    // );
  }

  List<Widget> buildPhraseListOrderedByFolder(context) {
    List<Widget> list = [];
    List<Widget> listExpansionTile = [];
    String folder = '';
    if (_phraseController.phraseList.isNotEmpty) {
      folder = _phraseController.phraseList.first.folder;
    }
    print('folder: $folder');
    for (var phrase in _phraseController.phraseList) {
      if (phrase.folder != folder) {
        listExpansionTile.add(
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black),
            ),
            child: ExpansionTile(
              title: Text(folder),
              children: [
                ...list,
              ],
            ),
          ),
        );
        list.clear();
        folder = phrase.folder;
      }
      list.add(
        PhraseCard(
          key: ValueKey(phrase),
          phrase: phrase,
          isPublic: phrase.isPublic,
          widgetList: [
            IconButton(
                tooltip: 'Classificar esta frase',
                icon: const Icon(AppIconData.letter),
                onPressed: () =>
                    Get.toNamed(Routes.phraseClassifying, arguments: phrase)),
            IconButton(
              tooltip: 'PDF da classificação desta frase.',
              icon: const Icon(AppIconData.print),
              onPressed: () async {
                Get.toNamed(Routes.pdf, arguments: phrase);
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
        ),
      );
    }
    if (_phraseController.phraseList.isNotEmpty) {
      listExpansionTile.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black),
          ),
          child: ExpansionTile(
            title: Text(folder),
            children: [
              ...list,
            ],
          ),
        ),
      );
    }
    if (listExpansionTile.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc ainda não criou nenhuma frase.'),
      ));
    }
    return listExpansionTile;
  }

  List<Widget> buildPhraseListOrderedByAlpha(context) {
    List<Widget> list = [];

    for (var phrase in _phraseController.phraseList) {
      list.add(
        PhraseCard(
          key: ValueKey(phrase),
          phrase: phrase,
          isPublic: phrase.isPublic,
          widgetList: [
            IconButton(
                tooltip: 'Classificar esta frase',
                icon: const Icon(AppIconData.letter),
                onPressed: () =>
                    Get.toNamed(Routes.phraseClassifying, arguments: phrase)),
            IconButton(
              tooltip: 'PDF da classificação desta frase.',
              icon: const Icon(AppIconData.print),
              onPressed: () async {
                Get.toNamed(Routes.pdf, arguments: phrase);
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
        ),
      );
    }

    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc ainda não criou nenhuma frase.'),
      ));
    }
    return list;
  }
}
