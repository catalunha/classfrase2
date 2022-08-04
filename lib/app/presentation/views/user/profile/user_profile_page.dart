import 'package:classfrase/app/presentation/controllers/user/profile/user_profile_controller.dart';
import 'package:classfrase/app/presentation/views/user/profile/part/user_profile_photo.dart';
import 'package:classfrase/app/presentation/views/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({Key? key}) : super(key: key);
  final UserProfileController _userProfileController = Get.find();

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  final _phoneTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTec.text = widget._userProfileController.userProfile?.name ?? "";
    _descriptionTec.text =
        widget._userProfileController.userProfile?.description ?? "";
    _phoneTec.text = widget._userProfileController.userProfile?.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      body: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextFormField(
                  label: 'Seu nome.',
                  controller: _nameTec,
                  validator: Validatorless.required('Nome é obrigatório'),
                ),
                AppTextFormField(
                  label: 'Uma breve descrição sobre você.',
                  controller: _descriptionTec,
                ),
                AppTextFormField(
                  label: 'Seu telefone com DDD.',
                  controller: _phoneTec,
                ),
                UserProfilePhoto(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final formValid =
                        _formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      await widget._userProfileController.append(
                        name: _nameTec.text,
                        description: _descriptionTec.text,
                        phone: _phoneTec.text,
                      );
                      Get.back();
                    }
                  },
                  child: const Text('Salvar atualização.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
