import 'dart:developer';

import 'package:classfrase/app/presentation/controllers/auth/login/login_controller.dart';
import 'package:classfrase/app/presentation/views/utils/app_button.dart';
import 'package:classfrase/app/presentation/views/utils/app_launch.dart';
import 'package:classfrase/app/presentation/views/utils/app_textformfield.dart';
import 'package:classfrase/app/presentation/views/utils/app_theme.dart';
import 'package:classfrase/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validatorless/validatorless.dart';

class AuthLoginPage extends StatefulWidget {
  final LoginController _loginController = Get.find();

  AuthLoginPage({Key? key}) : super(key: key);

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTec = TextEditingController();
  final _passwordTec = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppAppbar(),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constrainsts) {
          return Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constrainsts.maxHeight,
                  maxWidth: 400,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: context.textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColorDark,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextFormField(
                            label: 'Informe seu e-mail',
                            controller: _emailTec,
                            validator: Validatorless.multiple([
                              Validatorless.required('email obrigatório.'),
                              Validatorless.email('Email inválido.'),
                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AppTextFormField(
                            label: 'Informe a Senha',
                            controller: _passwordTec,
                            obscureText: true,
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Senha obrigatória.'),
                                Validatorless.min(6, 'Minimo de 6 caracteres.'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AppButton(
                            label: 'Acessar',
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                log('formValid');
                                widget._loginController.loginEmail(
                                    _emailTec.text.trim(),
                                    _passwordTec.text.trim());
                              } else {
                                log('formNotValid');
                              }
                            },
                            width: context.width,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Esqueceu sua senha ?'),
                              TextButton(
                                onPressed: () {
                                  if (_emailTec.text.isNotEmpty) {
                                    widget._loginController
                                        .forgotPassword(_emailTec.text.trim());
                                  } else {
                                    Get.snackbar(
                                      'Oops',
                                      'Digite email para prosseguir',
                                      backgroundColor: Colors.red,
                                      margin: const EdgeInsets.all(10),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Criar uma nova.',
                                  style: AppTheme.textBold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não possui uma conta ?'),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.authRegisterEmail);
                                },
                                child: const Text(
                                  'CADASTRE-SE.',
                                  style: AppTheme.textBold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => AppLaunch.launchLink(
                                    'https://bens.cemec.net.br/terms-of-use/'),
                                child: Text(
                                  'Terms of use',
                                  style: GoogleFonts.pacifico(fontSize: 14.0),
                                ),
                              ),
                              TextButton(
                                onPressed: () => AppLaunch.launchLink(
                                    'https://bens.cemec.net.br/privacy-policy/'),
                                child: Text(
                                  'Privacy policy',
                                  style: GoogleFonts.pacifico(fontSize: 14.0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
