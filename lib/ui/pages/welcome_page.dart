import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:get/get.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';
import 'package:untitled/ui/ui_compoments/h1.dart';
import '../ui_compoments/svg_asset_onpress.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 43.h),
              SvgAssetOnPress(
                iconString: 'assets/images/LOGO.svg',
                size: 39.52.w,
              ),
              Column(
                children: [
                  SizedBox(height: 145.h),
                  H1(
                    text: 'Choix du profil',
                    appSizes: 22.sp,
                    fontWeight: FontWeight.w700,
                    colors: AppColors.darkText,
                  ),

                  SizedBox(height: 40.h),

                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => _buildProfileCard(
                            title: 'Demandeur',
                            imagePath: 'assets/images/demandeur.png',
                            userType: UserType.demandeur,
                            isSelected:
                                controller.selectedUserType.value ==
                                UserType.demandeur,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Obx(
                          () => _buildProfileCard(
                            title: 'Transporteur',
                            imagePath: 'assets/images/transporteur.png',
                            userType: UserType.porteur,
                            isSelected:
                                controller.selectedUserType.value ==
                                UserType.porteur,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: Obx(() => ElevatedButton(
                      onPressed: controller.selectedUserType.value != null
                          ? controller.continueToHome
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.selectedUserType.value != null
                            ? AppColors.primary
                            : AppColors.scale_01,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Basculer',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: controller.selectedUserType.value != null
                              ? Colors.white
                              : AppColors.scale_03,
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String title,
    required String imagePath,
    required UserType userType,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => controller.selectUserType(userType),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 156.h,
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.scale_02, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 104.h,
                decoration: BoxDecoration(
                  color: AppColors.scale_01,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(9.r),
                    topLeft: Radius.circular(9.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(9.r),
                    topLeft: Radius.circular(9.r),
                  ),
                  child: _buildImageContent(userType, imagePath),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bgDark,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : AppColors.scale_03,
                        width:
                            isSelected
                                ? 0.w
                                : 2.w,
                      ),
                    ),
                    child:
                        isSelected
                            ? Icon(
                              Icons.check,
                              size: 12.sp,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContent(UserType userType, String imagePath) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholderImage(userType);
      },
    );
  }

  Widget _buildPlaceholderImage(UserType userType) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              userType == UserType.demandeur
                  ? [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primary.withOpacity(0.05),
                  ]
                  : [
                    AppColors.green.withOpacity(0.1),
                    AppColors.green.withOpacity(0.05),
                  ],
        ),
      ),
      child: Stack(
        children: [
          // Pattern de fond
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (userType == UserType.demandeur
                        ? AppColors.primary
                        : AppColors.green)
                    .withOpacity(0.1),
              ),
            ),
          ),
          Center(
            child: Icon(
              userType == UserType.demandeur
                  ? Icons.send_rounded
                  : Icons.local_shipping_rounded,
              size: 40.sp,
              color:
                  userType == UserType.demandeur
                      ? AppColors.primary
                      : AppColors.green,
            ),
          ),
          Positioned(
            top: 16.h,
            left: 16.w,
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (userType == UserType.demandeur
                        ? AppColors.primary
                        : AppColors.green)
                    .withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 24.h,
            right: 20.w,
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (userType == UserType.demandeur
                        ? AppColors.primary
                        : AppColors.green)
                    .withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
