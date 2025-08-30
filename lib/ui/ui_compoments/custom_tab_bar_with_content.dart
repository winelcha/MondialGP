import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';
import 'package:untitled/ui/ui_compoments/annonce_card.dart';

class CustomTabBarWithContent extends StatefulWidget {
  const CustomTabBarWithContent({Key? key}) : super(key: key);

  @override
  State<CustomTabBarWithContent> createState() =>
      _CustomTabBarWithContentState();
}

class _CustomTabBarWithContentState extends State<CustomTabBarWithContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 58.h,
          decoration: BoxDecoration(border: Border(bottom: BorderSide.none)),
          child: Stack(
            children: [
              Positioned(
                bottom: 9,
                left: 8,
                right: 0,
                child: Container(
                  height: 2.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.scale_02,
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.darkText,
                labelStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.h, color: AppColors.primary),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Annonces actives'),
                  Tab(text: 'Voyage en cours'),
                  Tab(text: 'Historique'),
                ],
              ),
            ],
          ),
        ),

        // TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAnnoncesActivesTab(),
              _buildVoyageEnCoursTab(),
              _buildHistoriqueTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnnoncesActivesTab() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (controller.annonces.isEmpty) {
            return _buildEmptyState(
              'Aucune annonce active',
              Icons.announcement,
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refreshAnnonces(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: controller.annonces.length,
              itemBuilder: (context, index) {
                final annonce = controller.annonces[index];
                return AnnonceCard(
                  annonce: annonce,
                  onTap: () => controller.goToAnnonceDetail(annonce),
                );
              },
            ),
          );
        });
      },
    );
  }

  Widget _buildVoyageEnCoursTab() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // Filtrer les annonces en transit
          final voyagesEnCours =
              controller.annonces
                  .where((annonce) => annonce.status == AnnonceStatus.inTransit)
                  .toList();

          if (voyagesEnCours.isEmpty) {
            return _buildEmptyState(
              'Aucun voyage en cours',
              Icons.flight_takeoff,
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refreshAnnonces(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: voyagesEnCours.length,
              itemBuilder: (context, index) {
                final annonce = voyagesEnCours[index];
                return AnnonceCard(
                  annonce: annonce,
                  onTap: () => controller.goToAnnonceDetail(annonce),
                );
              },
            ),
          );
        });
      },
    );
  }

  Widget _buildHistoriqueTab() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          // Filtrer les annonces livrées ou annulées
          final historique =
              controller.annonces
                  .where(
                    (annonce) =>
                        annonce.status == AnnonceStatus.delivered ||
                        annonce.status == AnnonceStatus.cancelled,
                  )
                  .toList();

          if (historique.isEmpty) {
            return _buildEmptyState('Aucun historique', Icons.history);
          }

          return RefreshIndicator(
            onRefresh: () async => controller.refreshAnnonces(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: historique.length,
              itemBuilder: (context, index) {
                final annonce = historique[index];
                return AnnonceCard(
                  annonce: annonce,
                  onTap: () => controller.goToAnnonceDetail(annonce),
                );
              },
            ),
          );
        });
      },
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48.sp, color: AppColors.primary),
            ),
            SizedBox(height: 24.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Tirez vers le bas pour actualiser',
              style: TextStyle(fontSize: 16.sp, color: AppColors.secondary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.find<HomeController>().refreshAnnonces(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, size: 20.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    'Actualiser',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
