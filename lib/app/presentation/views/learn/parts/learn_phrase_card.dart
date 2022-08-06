import 'package:classfrase/app/domain/models/phrase_model.dart';
import 'package:flutter/material.dart';

class LearnPhraseCard extends StatelessWidget {
  final PhraseModel phraseModel;
  final List<Widget>? widgetList;
  const LearnPhraseCard({
    Key? key,
    required this.phraseModel,
    this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            tileColor: Colors.yellow,
            title: Text(
              phraseModel.phrase,
              // style: AppTextStyles.buttonBoldHeading,
            ),
            subtitle: Text(
              '${phraseModel.font ?? 'Fonte: ?'}\n ${phraseModel.folder}',
            ),
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
