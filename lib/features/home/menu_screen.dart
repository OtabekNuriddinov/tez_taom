import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tez_taom/features/settings/settings_screen.dart';
import '../../components/category_card.dart';
import '../../components/promo_carousel.dart';
import '../detail/food_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'appName'.tr(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          PromoCarousel(),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                CategoryCard(
                  title: 'Gamburger',
                  icon: Icons.lunch_dining,
                  color: Colors.orange,
                  onTap: () => _navigateToCategory(context, 'Gamburger'),
                ),
                CategoryCard(
                  title: 'Hot Dog',
                  icon: Icons.fastfood,
                  color: Colors.red,
                  onTap: () => _navigateToCategory(context, 'Hot Dog'),
                ),
                CategoryCard(
                  title: 'Pizza',
                  icon: Icons.local_pizza,
                  color: Colors.green,
                  onTap: () => _navigateToCategory(context, 'Pizza'),
                ),
                CategoryCard(
                  title: 'Ichimliklar',
                  icon: Icons.local_drink,
                  color: Colors.blue,
                  onTap: () => _navigateToCategory(context, 'Ichimliklar'),
                ),
                CategoryCard(
                  title: 'Sneklar',
                  icon: Icons.cake,
                  color: Colors.purple,
                  onTap: () => _navigateToCategory(context, 'Sneklar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(category: category),
      ),
    );
  }
}
