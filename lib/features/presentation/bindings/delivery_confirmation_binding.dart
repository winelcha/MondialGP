import 'package:get/get.dart';
import 'package:untitled/features/presentation/controllers/delivery_confirmation_controller.dart';

class DeliveryConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryConfirmationController());
  }
}