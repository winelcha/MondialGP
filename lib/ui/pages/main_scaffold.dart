import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/features/presentation/controllers/main_controller.dart';
import 'package:untitled/ui/pages/home_page.dart';

import '../styles/colors.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());

    final List<Widget> screens = [
      const HomePage(),
      Container(),
      Container(),
      Container(),
    ];

    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgWhite,
          body: screens[mainController.currentIndex.value],
          bottomNavigationBar: SizedBox(
            height: 93.h,
            child: BottomNavigationBar(
              elevation: 8.h,
              backgroundColor: AppColors.bgWhite,
              type: BottomNavigationBarType.fixed,
              currentIndex: mainController.currentIndex.value,
              selectedFontSize: 12.sp,
              unselectedFontSize: 11.sp,
              selectedLabelStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                color: AppColors.secondary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              unselectedItemColor: AppColors.secondary,
              selectedItemColor: AppColors.primary,
              onTap: mainController.changeTab,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.home_outlined,
                      color:
                          mainController.currentIndex.value == 0
                              ? AppColors.primary
                              : AppColors.secondary,
                      size: 24.sp,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.home,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      color:
                          mainController.currentIndex.value == 1
                              ? AppColors.primary
                              : AppColors.secondary,
                      size: 24.sp,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.local_shipping,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                  label: 'Message',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color:
                          mainController.currentIndex.value == 2
                              ? AppColors.primary
                              : AppColors.secondary,
                      size: 24.sp,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.person_outline,
                      color:
                          mainController.currentIndex.value == 2
                              ? AppColors.primary
                              : AppColors.secondary,
                      size: 24.sp,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                  ),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
