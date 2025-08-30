import 'package:get/get.dart';
import '../controllers/annonce_controller.dart';
class AnnonceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnonceController());
  }
}