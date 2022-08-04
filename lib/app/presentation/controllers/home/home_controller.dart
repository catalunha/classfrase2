import 'package:classfrase/app/domain/usecases/auth/auth_usecase.dart';
import 'package:classfrase/app/presentation/controllers/utils/loader_mixin.dart';
import 'package:classfrase/app/presentation/controllers/utils/message_mixin.dart';
import 'package:classfrase/app/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderMixin, MessageMixin {
  final AuthUseCase _authUseCase;

  HomeController({required AuthUseCase authUseCase})
      : _authUseCase = authUseCase;

  final _loading = false.obs;
  set loading(bool value) => _loading(value);
  final _message = Rxn<MessageModel>();

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> logout() async {
    print('em home logout ');
    await _authUseCase.logout();
    Get.offAllNamed(Routes.authLogin);
  }
}
