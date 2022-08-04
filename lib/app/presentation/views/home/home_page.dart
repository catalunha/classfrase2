import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/home/home_controller.dart';
import 'package:classfrase/app/presentation/views/home/parts/popmenu_user.dart';
import 'package:classfrase/app/presentation/views/utils/app_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final HomeController _homeController = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: appBarTitle(),
        actions: [
          PopMenuButtonPhotoUser(),
        ],
      ),
    );
  }

  Widget appBarTitle() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem vindo(a),',
              style: TextStyle(fontSize: 12),
            ),
            Text(widget._splashController.userModel?.profile?.name == null
                ? "Atualize seu perfil."
                : widget._splashController.userModel!.profile!.name!),
          ],
        ));
  }
}
