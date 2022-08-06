import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/presentation/views/learn/parts/person_tile.dart';
import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  final String? folder;
  final UserModel userModel;
  final List<Widget>? widgetList;

  const LearnCard({
    Key? key,
    required this.userModel,
    this.widgetList,
    required this.folder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(folder ?? '/'),
          ),
          PersonTile(
            displayName: userModel.profile!.name,
            photoURL: userModel.profile!.photo,
            email: userModel.email,
          ),
          Center(
            child: Wrap(
              children: widgetList ?? [],
            ),
          )
        ],
      ),
    );
  }
}
