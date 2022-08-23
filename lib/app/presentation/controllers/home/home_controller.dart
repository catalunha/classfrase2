import 'package:classfrase/app/domain/usecases/auth/auth_usecase.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final AuthUseCase _authUseCase;

  HomeController({
    required AuthUseCase authUseCase,
  }) : _authUseCase = authUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> logout() async {
    print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }

  // createAccount() async {
  //   List<String> list = <String>[];
  //   list.add('1001enzo1001@gmail.com');
  //   list.add('adrianarozzi@gmail.com');
  //   list.add('afrgloria@gmail.com');
  //   list.add('alinecostadl@gmail.com');
  //   list.add('alinegalvao2639@gmail.com');
  //   list.add('ambiental.costa@gmail.com');
  //   list.add('anacarol.s.oliveira@gmail.com');
  //   list.add('anargmontefusco@gmail.com');
  //   list.add('andqualidade@gmail.com');
  //   list.add('andre.editora@gmail.com');
  //   list.add('andreamonferrari@gmail.com');
  //   list.add('ashirleycuthebert@gmail.com');
  //   list.add('barbrareis@gmail.com');
  //   list.add('benevides.homeschool@gmail.com');
  //   list.add('bernardovalmeida11@gmail.com');
  //   list.add('bettyfranca82@gmail.com');
  //   list.add('brintec.education@gmail.com');
  //   list.add('carolinatiefel@gmail.com');
  //   list.add('cecy.vexenat@gmail.com');
  //   list.add('chrismnv.nunes@gmail.com');
  //   list.add('claciadias@gmail.com');
  //   list.add('cmteguizu@gmail.com');
  //   list.add('cortes.mastercoach@gmail.com');
  //   list.add('creshbala@hotmail.com');
  //   list.add('cristiano.avaney@gmail.com');
  //   list.add('damarisobrito@gmail.com');
  //   list.add('danisinha.melo@gmail.com');
  //   list.add('eliapeggymarcelo@gmail.com');
  //   list.add('ellencriss@gmail.com');
  //   list.add('enzo1001reis1001@gmail.com');
  //   list.add('evertonadvogado1981@gmail.com');
  //   list.add('fontestatianna@gmail.com');
  //   list.add('fredi.bieging@gmail.com');
  //   list.add('gabriel.vexenat@gmail.com');
  //   list.add('gabriela.gabigbl@gmail.com');
  //   list.add('gersonetelma@gmail.com');
  //   list.add('gipianoraw@gmail.com');
  //   list.add('guimaraesthyara@gmail.com');
  //   list.add('izairabotelho@gmail.com');
  //   list.add('joaomacedo8503@gmail.com');
  //   list.add('katiaguara@gmail.com');
  //   list.add('lamorim100@gmail.com');
  //   list.add('lauro.rose@gmail.com');
  //   list.add('lilian.neves@gmail.com');
  //   list.add('louisadrian777@gmail.com');
  //   list.add('luamorim605@gmail.com');
  //   list.add('lucaslcatalunha@gmail.com');
  //   list.add('lucca.eterno@gmail.com');
  //   list.add('luciana22reis@gmail.com');
  //   list.add('marcio.gomes@centrosuzukidebrasilia.com');
  //   list.add('marconegoval@gmail.com');
  //   list.add('mari.mello.borges@gmail.com');
  //   list.add('mariaclara.vexenat@gmail.com');
  //   list.add('mario@mosfera.com');
  //   list.add('maryellendacunha@gmail.com');
  //   list.add('mateuspeduzzi@gmail.com');
  //   list.add('mcdpfirmino@gmail.com');
  //   list.add('melo.fabio33@gmail.com');
  //   list.add('michellycaetano@gmail.com');
  //   list.add('milenaszw@gmail.com');
  //   list.add('mimiguelmarcal@gmail.com');
  //   list.add('monicabrcorrea@hotmail.com');
  //   list.add('nandapaiva1990@gmail.com');
  //   list.add('nayzuchi@gmail.com');
  //   list.add('nogueiraguimaraesmarcelo@gmail.com');
  //   list.add('oluap.castelo@gmail.com');
  //   list.add('pacco.brasilia@gmail.com');
  //   list.add('paulajaccoud.farmaceutica@gmail.com');
  //   list.add('profamarlenechagas@gmail.com');
  //   list.add('querencostaalvesss@gmail.com');
  //   list.add('raqueltedesco20@gmail.com');
  //   list.add('rcms.305@gmail.com');
  //   list.add('rejanecristina.rcva@gmail.com');
  //   list.add('ricardoclodoaldo@hotmail.com');
  //   list.add('ricelly.catalunha@gmail.com');
  //   list.add('ronielha1@gmail.com');
  //   list.add('rubenitoam@gmail.com');
  //   list.add('rutevlgv2016@gmail.com');
  //   list.add('silvailderocha@gmail.com');
  //   list.add('silviobless@gmail.com');
  //   list.add('sorayasousasilva417@gmail.com');
  //   list.add('taleia.borges@gmail.com');
  //   list.add('tatianeprofe@gmail.com');
  //   list.add('tmspalmeida@gmail.com');
  //   list.add('vaniaregina10@gmail.com');
  //   list.add('veronezcamilaa@gmail.com');
  //   for (var element in list) {
  //     print(element);
  //     final user = ParseUser.createUser(element, '123456', element);
  //     await user.signUp();
  //   }
  // }
}
