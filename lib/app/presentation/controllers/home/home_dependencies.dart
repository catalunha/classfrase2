import 'package:classfrase/app/presentation/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class HomeDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(authUseCase: Get.find()),
    );
  }
}
