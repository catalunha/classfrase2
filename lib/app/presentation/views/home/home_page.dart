import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/home/home_controller.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/views/home/parts/popmenu_user.dart';
import 'package:classfrase/app/presentation/views/phrase/list/parts/phrase_list.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final PhraseController _phraseController = Get.find();
  final HomeController _homeController = Get.find();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${widget._splashController.userModel!.profile!.name ?? 'Atualize seu perfil.'}.")),
        actions: [
          // const IconButton(
          //     onPressed: () => widget._homeController.createAccount(),
          //     icon: Icon(Icons.abc)),
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          optionsForUse(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              phraseInClass(),
              sortAlpha(context),
              sortFolder(context),
              phraseArchived(context),
            ],
          ),
          Expanded(
            child: PhraseList(),
          ),
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

  optionsForUse(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message:
                  'Clique aqui para criar uma frase e depois classificá-la.',
              child: SizedBox(
                width: 170,
                child: ElevatedButton.icon(
                  onPressed: () => widget._phraseController.add(),
                  icon: const Icon(AppIconData.phrase),
                  label: const Text('Criar frase.'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const SizedBox(width: 10),
            Tooltip(
              message:
                  'Clique aqui para aprender com a classificação de outras pessoas.',
              child: SizedBox(
                width: 170,
                child: ElevatedButton.icon(
                  onPressed: () => Get.toNamed(Routes.learnList),
                  icon: const Icon(AppIconData.learn),
                  label: const Text('Aprender.'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded phraseInClass() {
    return Expanded(
      flex: 5,
      child: Container(
        height: 30,
        color: Colors.black12,
        child: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Text(
              'Minhas frases em classificação.',
            ),
          ],
        ),
      ),
    );
  }

  Expanded phraseArchived(BuildContext context) {
    return Expanded(
        flex: 1,
        child: IconButton(
          tooltip: 'Minhas frases arquivadas',
          icon: const Icon(AppIconData.box),
          onPressed: () => widget._phraseController.listArchived(),
        ));
  }

  Expanded sortAlpha(BuildContext context) {
    return Expanded(
        flex: 1,
        child: IconButton(
          tooltip: 'Ordenação alfabética das frases',
          icon: Obx(() => Icon(
                AppIconData.sortAlpha,
                color: !widget._phraseController.isSortedByFolder.value
                    ? Colors.green
                    : Colors.black,
              )),
          onPressed: () => widget._phraseController.sortByFolder(false),
        ));
  }

  Expanded sortFolder(BuildContext context) {
    return Expanded(
        flex: 1,
        child: IconButton(
          tooltip: 'Ordenação por folder das frases',
          icon: Obx(() => Icon(
                AppIconData.sortFolder,
                color: widget._phraseController.isSortedByFolder.value
                    ? Colors.green
                    : Colors.black,
              )),
          onPressed: () => widget._phraseController.sortByFolder(true),
        ));
  }
}
