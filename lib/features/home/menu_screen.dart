import 'package:flutter/material.dart';
import 'package:tez_taom/components/category_card.dart';
import 'package:tez_taom/features/settings/settings_screen.dart';
import '../../components/promo_carousel.dart';
import '../detail/food_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../components/app_background.dart';
import '../../components/app_header.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'appName'.tr(),
                rightWidget: IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                ),
              ),
              // Promo Carousel
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: PromoCarousel(),
              ),
              const SizedBox(height: 16),
              // Categories Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      CategoryCard(
                          title: "Hamburger",
                          iconUrl: "assets/icons/burger.png",
                          onTap: () => _navigateToCategory(context, 'Gamburger'),
                      ),
                      CategoryCard(
                          title: "Hot Dog",
                          iconUrl: "assets/icons/hotdog.png",
                          onTap: () => _navigateToCategory(context, 'Hot Dog')
                      ),
                      CategoryCard(
                          title: "Pizza",
                          iconUrl: "assets/icons/pizza.png",
                          onTap: () => _navigateToCategory(context, "Pizza")
                      ),
                     CategoryCard(
                         title: "Ichimliklar",
                         iconUrl: "assets/icons/soft-drink.png",
                         onTap: () => _navigateToCategory(context, "Ichimliklar")
                     ),
                      CategoryCard(
                          title: "Sneklar",
                          iconUrl: "assets/icons/snack.png",
                          onTap: () => _navigateToCategory(context, "Sneklar")
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
