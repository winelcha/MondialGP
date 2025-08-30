import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/data/services/mock_service.dart';
import 'package:untitled/features/data/services/shared_preferences_service.dart';
import 'package:untitled/router/app_router.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:responsive_framework/responsive_framework.dart' as rf;

import 'features/presentation/controllers/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  print('🚀 Initialisation des services...');

  try {
    await Get.putAsync(() => SharedPreferencesService().init());
    await Get.putAsync(() => MockService().init());
    Get.put(AuthController(), permanent: true);
    Get.put(HomeController(), permanent: true);

    log('✅ Services initialisés avec succès');
  } catch (e) {
    log('❌ Erreur lors de l\'initialisation: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MondialGP',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: AppColors.primary,
            fontFamily: "Euclid Circular A",
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          initialRoute: AppRouter.INITIAL,
          getPages: AppRouter.routes,
          builder: (_, child) {
            return rf.ResponsiveBreakpoints.builder(
              child: Builder(
                builder: (context) {
                  return rf.MaxWidthBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    child: rf.ResponsiveScaledBox(
                      width: rf.ResponsiveValue<double>(
                        context,
                        defaultValue: 450,
                        conditionalValues: [
                          rf.Condition.equals(name: rf.MOBILE, value: 450),
                          rf.Condition.between(start: 800, end: 1100, value: 800),
                          rf.Condition.between(
                            start: 1000,
                            end: 1200,
                            value: 1000,
                          ),
                        ],
                      ).value,
                      child: rf.BouncingScrollWrapper.builder(
                        context,
                        child!,
                        dragWithMouse: true,
                      ),
                    ),
                  );
                },
              ),
              breakpoints: const [
                rf.Breakpoint(
                  start: 0,
                  end: 450,
                  name: rf.MOBILE,
                ),
                rf.Breakpoint(
                  start: 451,
                  end: 800,
                  name: rf.TABLET,
                ),
                rf.Breakpoint(
                  start: 801,
                  end: 1920,
                  name: rf.DESKTOP,
                ),
                rf.Breakpoint(
                  start: 1921,
                  end: double.infinity,
                  name: '4K',
                ),
              ],
            );
          },
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
          unknownRoute: GetPage(
            name: '/not-found',
            page: () => const NotFoundPage(),
          ),
          enableLog: true,
          logWriterCallback: (String text, {bool isError = false}) {
            if (isError) {
              print('🚨 GetX Error: $text');
            } else {
              print('📝 GetX Log: $text');
            }
          },
        );
      },
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page non trouvée')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: AppColors.red),
            SizedBox(height: 16.h),
            Text(
              'Page non trouvée',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.bgDark,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Cette page n\'existe pas',
              style: TextStyle(fontSize: 16.sp, color: AppColors.bgDark),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRouter.INITIAL),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
