import 'package:classfrase/app/domain/models/user_model.dart';
import 'package:classfrase/app/presentation/views/learn/parts/person_tile.dart';
import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  final UserModel userModel;
  final List<Widget>? widgetList;

  const LearnCard({
    Key? key,
    required this.userModel,
    this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          PersonTile(
            community: userModel.profile!.community,
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
