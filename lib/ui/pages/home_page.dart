import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';
import 'package:untitled/ui/ui_compoments/collissimo_card.dart';
import 'package:untitled/ui/ui_compoments/custom_tab_bar_with_content.dart';
import '../ui_compoments/h1.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16.w), child: _buildHeader()),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 320.w,
                            child: CollissimoCard(
                              title: 'Colis en cours de voyage',
                              count: '2',
                              imagePath: "assets/images/valise.png",
                              onTap: () => print('Voyage cliqué'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          SizedBox(
                            width: 295.w,
                            child: CollissimoCard(
                              title: 'Colis livrés',
                              count: '5',
                              imagePath: '',
                              onTap: () => print('Livrés cliqué'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          SizedBox(
                            width: 295.w,
                            child: CollissimoCard(
                              title: 'Colis en attente',
                              count: '3',
                              imagePath: '',
                              onTap: () => print('Attente cliqué'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                  Expanded(child: CustomTabBarWithContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180.w,
                child: H1(
                  text: 'Bonjour Christian 👋',
                  appSizes: 27.sp,
                  fontWeight: FontWeight.w600,
                  colors: AppColors.darkText,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 22.sp, color: Colors.white),
              SizedBox(width: 2.w),
              SizedBox(
                width: 80.w,
                child: H1(
                  text:  'Créer une annonce',
                  appSizes: 18.sp,
                  fontWeight: FontWeight.w500,
                  colors: Colors.white,
                  height: 1.2, align: TextAlign.center,
                  maxLines: 2,
                ),

              ),
            ],
          ),
        )
      ],
    );
  }
}
