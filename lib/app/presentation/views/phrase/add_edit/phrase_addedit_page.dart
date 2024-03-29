import 'package:classfrase/app/presentation/controllers/phrase/phrase_controller.dart';
import 'package:classfrase/app/presentation/views/utils/app_icon.dart';
import 'package:classfrase/app/presentation/views/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class PhraseAddEditPage extends StatefulWidget {
  final PhraseController _phraseController = Get.find();

  PhraseAddEditPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PhraseAddEditPage> createState() => _PhraseAddEditPageState();
}

class _PhraseAddEditPageState extends State<PhraseAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _phraseTEC = TextEditingController();
  final _fontTEC = TextEditingController();
  final _folderTEC = TextEditingController();
  final _diagramUrlTEC = TextEditingController();
  final _noteTEC = TextEditingController();
  bool _isArchived = false;
  bool _isPublic = false;
  bool _isDeleted = false;
  @override
  void initState() {
    super.initState();
    _phraseTEC.text = widget._phraseController.phrase?.phrase ?? '';
    _fontTEC.text = widget._phraseController.phrase?.font ?? '';
    _folderTEC.text = widget._phraseController.phrase?.folder ?? '';
    _diagramUrlTEC.text = widget._phraseController.phrase?.diagramUrl ?? '';
    _noteTEC.text = widget._phraseController.phrase?.note ?? '';
    _isArchived = widget._phraseController.phrase?.isArchived ?? false;
    _isPublic = widget._phraseController.phrase?.isPublic ?? false;
    _isDeleted = widget._phraseController.phrase?.isDeleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._phraseController.phrase == null
            ? 'Adicionar uma frase'
            : 'Editar esta frase'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                AppTextFormField(
                  label: 'Informe a frase',
                  controller: _phraseTEC,
                  validator: Validatorless.required('frase é obrigatória'),
                ),
                AppTextFormField(
                  label: 'Pasta desta frase',
                  controller: _folderTEC,
                ),
                AppTextFormField(
                  label: 'Fonte desta frase',
                  controller: _fontTEC,
                ),
                AppTextFormField(
                  label: 'Observações',
                  controller: _noteTEC,
                  maxLines: 5,
                ),
                AppTextFormField(
                  label: 'Link para o diagrama online desta frase',
                  controller: _diagramUrlTEC,
                ),
                CheckboxListTile(
                  title: const Text("Publicar esta frase"),
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                  value: _isPublic,
                ),
                CheckboxListTile(
                  title: const Text("Arquivar esta frase"),
                  onChanged: (value) {
                    setState(() {
                      _isArchived = value!;
                    });
                  },
                  value: _isArchived,
                ),
                widget._phraseController.phrase == null
                    ? Container()
                    : CheckboxListTile(
                        tileColor: _isDeleted ? Colors.red : null,
                        title: const Text("Apagar esta frase"),
                        onChanged: (value) {
                          setState(() {
                            _isDeleted = value!;
                          });
                        },
                        value: _isDeleted,
                      ),
                const SizedBox(height: 120),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar estes campos em núvem',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._phraseController.addedit(
              phrase: _phraseTEC.text,
              folder: _folderTEC.text,
              font: _fontTEC.text,
              diagramUrl: _diagramUrlTEC.text,
              note: _noteTEC.text,
              isPublic: _isPublic,
              isArchived: _isArchived,
              isDeleted: _isDeleted,
            );
            Get.back();
          }
        },
      ),
    );
  }
}
