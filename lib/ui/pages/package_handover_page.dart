
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/router/app_router.dart';
import 'dart:io';
import 'package:untitled/features/presentation/controllers/controllers.dart';

import '../styles/styles.dart';

class PackageHandoverPage extends GetView<PackageHandoverController> {
  const PackageHandoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remise du colis'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnnonceInfo(),
            SizedBox(height: 24.h),
            _buildPhotoSection(),
            SizedBox(height: 24.h),
            _buildPinCodeSection(),
            SizedBox(height: 32.h),
            _buildValidateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnonceInfo() {
    return Obx(() {
      final annonce = controller.annonce.value;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.green, AppColors.green.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color:AppColors.bgWhite,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Remise du colis',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color:AppColors.bgWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${annonce?.origin} → ${annonce?.destination}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color:AppColors.bgWhite,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'GP: ${annonce?.gpName} • ${annonce?.weight} kg',
              style: TextStyle(
                fontSize: 14.sp,
                color:AppColors.bgWhite.withOpacity(0.9),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPhotoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.camera_alt,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Photos du colis',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Prenez des photos du colis avant la remise',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 16.h),
          Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.w,
              ),
              itemCount: controller.photos.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.photos.length) {
                  return _buildAddPhotoButton();
                }
                return _buildPhotoItem(controller.photos[index], index);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return GestureDetector(
      onTap: controller.showImageSourceDialog,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.scale_01,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary,
            width: 2.w,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 32.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 4.h),
            Text(
              'Ajouter',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoItem(File photo, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: FileImage(photo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 4.w,
            right: 4.w,
            child: GestureDetector(
              onTap: () => controller.removePhoto(index),
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.close,
                  size: 16.sp,
                  color:AppColors.bgWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinCodeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.3),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.pin,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Code de confirmation',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: controller.showValidationMethodDialog,
                icon: Icon(
                  Icons.help_outline,
                  color: AppColors.secondary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Saisissez le code PIN OU scannez le QR code',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 16.h),

          // Section QR Code
          Obx(() => controller.scannedQrCode.value.isNotEmpty
              ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.green),
            ),
            child: Row(
              children: [
                Icon(Icons.qr_code, color: AppColors.green, size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'QR Code scanné avec succès',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.clearCodes,
                  icon: Icon(Icons.clear, color: AppColors.red, size: 18.sp),
                ),
              ],
            ),
          )
              : SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: controller.scanQrCode,
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scanner QR Code'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          ),

          SizedBox(height: 16.h),

          // Divider OU
          Row(
            children: [
              Expanded(child: Divider(color: AppColors.bgDark)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'OU',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Divider(color: AppColors.bgDark)),
            ],
          ),

          SizedBox(height: 16.h),

          // Section PIN
          TextField(
            onChanged: controller.updatePinCode,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 8.w,
            ),
            decoration: InputDecoration(
              hintText: '____',
              hintStyle: TextStyle(
                fontSize: 24.sp,
                color: AppColors.scale_01,
                letterSpacing: 8.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.bgDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.primary, width: 2.w),
              ),
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildValidateButton() {
    return Obx(() {
      final canValidate = (controller.enteredPinCode.value.length == 4 ||
          controller.scannedQrCode.value.isNotEmpty) &&
          controller.photos.isNotEmpty;

      return SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: canValidate && !controller.isValidatingCode.value
              ? controller.validateCode  // Utiliser validateCode au lieu de validatePinCode
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canValidate
                ? AppColors.green
                : AppColors.scale_01,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: controller.isValidatingCode.value
              ? SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.bgWhite),
            ),
          )
              : Text(
            'Confirmer la remise',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.bgWhite,
            ),
          ),
        ),
      );
    });
  }
}