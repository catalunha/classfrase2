import 'package:classfrase/app/presentation/controllers/learn/learn_controller.dart';
import 'package:classfrase/app/presentation/views/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class LearnAddPerson extends StatefulWidget {
  final LearnController _learnController = Get.find();

  // final FormControllerLearnUserAdd formControllerLearnUserAdd;
  // final Function(String) onSave;

  LearnAddPerson({
    Key? key,
    // required this.formControllerLearnUserAdd,
    // required this.onSave,
  }) : super(key: key);

  @override
  State<LearnAddPerson> createState() => _LearnAddPersonState();
}

class _LearnAddPersonState extends State<LearnAddPerson> {
  final _formKey = GlobalKey<FormState>();
  final _emailTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _emailTEC.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Adicionar apenas uma pessoa'),
                AppTextFormField(
                  label: 'Informe o email',
                  controller: _emailTEC,
                  validator: Validatorless.required('email é obrigatório'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    const SizedBox(
                      width: 50,
                    ),
                    TextButton(
                        onPressed: () async {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            await widget._learnController.add(
                              email: _emailTEC.text,
                            );
                            // Navigator.pop(context);
                          }
                        },
                        child: const Text('Buscar')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
