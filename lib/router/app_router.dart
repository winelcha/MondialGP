import 'package:get/get.dart';
import 'package:untitled/ui/pages/pages.dart';

import '../features/presentation/bindings/bindings.dart';
import '../features/presentation/controllers/main_controller.dart';
import '../ui/pages/main_scaffold.dart';

class AppRouter {
  static const INITIAL = '/welcome';
  static const MAIN = '/main';
  static const HOME = '/home';
  static const ANNONCE_DETAIL = '/annonce-detail';
  static const STATUS_CHANGE = '/status-change';
  static const QR_GENERATION = '/qr-generation';
  static const PACKAGE_HANDOVER = '/photo-capture';
  static const DELIVERY_CONFIRMATION = '/delivery-confirmation';
  static const QR_SCANNER = '/qr-scanner';

  static final routes = [
    GetPage(
      name: INITIAL,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(name: MAIN, page: () => MainScaffold(), binding: MainBinding()),
    GetPage(name: HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
      name: ANNONCE_DETAIL,
      page: () => AnnonceDetailPage(),
      binding: AnnonceDetailBinding(),
    ),
    GetPage(
      name: QR_GENERATION,
      page: () => QrGenerationPage(),
      binding: QRGenerationBinding(),
    ),
    GetPage(
      name: PACKAGE_HANDOVER,
      page: () => const PackageHandoverPage(),
      binding: PackageHandoverBinding(),
    ),
    GetPage(
      name: DELIVERY_CONFIRMATION,
      page: () => DeliveryConfirmationPage(),
      binding: DeliveryConfirmationBinding(),
    ),
  ];
}


