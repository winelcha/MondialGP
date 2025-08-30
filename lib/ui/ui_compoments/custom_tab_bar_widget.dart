import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/styles.dart';


class CustomTabBarAlternative extends StatefulWidget {
  const CustomTabBarAlternative({Key? key}) : super(key: key);

  @override
  State<CustomTabBarAlternative> createState() => _CustomTabBarAlternativeState();
}

class _CustomTabBarAlternativeState extends State<CustomTabBarAlternative>
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
          height: 50.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.scale_02,
                width: 1.h,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF1A1A1A), // Couleur noire pour le texte sélectionné
            unselectedLabelColor: AppColors.secondary,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0, // Épaisseur de l'indicateur bleu
                color: Color(0xFF2B5CE6), // Bleu comme dans l'image
              ),
              insets: EdgeInsets.symmetric(horizontal: 30.0), // Largeur réduite de l'indicateur
            ),
            indicatorSize: TabBarIndicatorSize.label, // L'indicateur suit la largeur du texte
            dividerColor: Colors.transparent, // Pas de ligne par défaut
            tabs: const [
              Tab(text: 'Annonces actives'),
              Tab(text: 'Voyage en cours'),
              Tab(text: 'Historique'),
            ],
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabContent('Annonces actives', Icons.announcement),
              _buildTabContent('Voyage en cours', Icons.flight_takeoff),
              _buildTabContent('Historique', Icons.history),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 40.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            'Contenu de l\'onglet $title sera affiché ici',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.black, // Couleur du texte sélectionné
      unselectedLabelColor: Colors.grey, // Couleur du texte non sélectionné
      labelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.h,
          color: Color(0xFF2B5CE6), // Bleu comme dans votre image
        ),
        insets: EdgeInsets.symmetric(horizontal: 30.w),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Color(0xFFE5E5E5), // Ligne grise de base
      tabs: [
        Tab(text: 'Annonces actives'),
        Tab(text: 'Voyage en cours'),
        Tab(text: 'Historique'),
      ],
    );
  }
}