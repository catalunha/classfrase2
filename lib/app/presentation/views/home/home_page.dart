import 'package:classfrase/app/presentation/controllers/auth/splash/splash_controller.dart';
import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/views/home/parts/popmenu_user.dart';
import 'package:classfrase/app/presentation/views/phrase/list/parts/phrase_list.dart';
import 'package:classfrase/app/presentation/views/utils/app_appbar.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final SplashController _splashController = Get.find();
  final PhraseController _phraseController = Get.find();

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
      body: Column(
        children: [
          // admin(context),
          const Center(child: Text('Como deseja usar o ClassFrase ?')),
          optionsForUse(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              phraseInClass(),
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
              message: 'Para criar uma frase e classificá-la.',
              child: SizedBox(
                width: 130,
                child: ElevatedButton.icon(
                  onPressed: () => widget._phraseController.add(),
                  icon: const Icon(AppIconData.phrase),
                  label: const Text('Criar.'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Tooltip(
            //   message: 'Para observar frases em classificação em tempo real.',
            //   child: Container(
            //     width: 130,
            //     child: ElevatedButton.icon(
            //       onPressed: () => Navigator.pushNamed(
            //         context,
            //         '/observer_list',
            //         arguments: '',
            //       ),
            //       icon: Icon(AppIconData.eye),
            //       label: Text('Observar.'),
            //     ),
            //   ),
            // ),
            const SizedBox(width: 10),
            Tooltip(
              message: 'Para aprender com a classificação de outras pessoas.',
              child: SizedBox(
                width: 130,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/learn',
                    arguments: '',
                  ),
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
              'Minhas frases em classificação ',
              // style: AppTextStyles.trailingBold,
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
}
