import 'package:classfrase/app/presentation/controllers/auth/email/auth_register_email_controller.dart';
import 'package:get/get.dart';

class AuthRegisterEmailDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRegisterEmailController>(
        () => AuthRegisterEmailController(authUseCase: Get.find()));
  }
}
