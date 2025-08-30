import 'package:get/get.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';

class PackageHandoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackageHandoverController());
  }
}
