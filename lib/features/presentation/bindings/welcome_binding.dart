import 'package:get/get.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';
class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}