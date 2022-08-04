import 'package:flutter/material.dart';

class AppAppbar extends AppBar {
  AppAppbar({
    Key? key,
    super.actions,
    super.title,
  }) : super(
          key: key,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          // centerTitle: true,
          // title: Image.asset(
          //   AppAssets.logo,
          //   width: 170,
          // ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          // actions: [
          //   logout != null
          //       ? IconButton(
          //           onPressed: logout, icon: const Icon(Icons.exit_to_app))
          //       : const SizedBox()
          // ],
        );
}
