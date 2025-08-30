import 'package:get/get.dart';

import 'package:untitled/features/presentation/controllers/controllers.dart';
class QRGenerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrGenerationController());
  }
}
