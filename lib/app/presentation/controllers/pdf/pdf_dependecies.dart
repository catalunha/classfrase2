import 'package:classfrase/app/presentation/controllers/pdf/pdf_controller.dart';
import 'package:get/get.dart';

class PdfDependencies implements Bindings {
  @override
  void dependencies() {
    Get.put<PdfController>(
      PdfController(),
    );
  }
}
