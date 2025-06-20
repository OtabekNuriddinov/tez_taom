import 'package:flutter/material.dart';
import '../../components/food_item_card.dart';
import '../../data/food_items.dart';
import '../settings/settings_screen.dart';
import '../../components/app_background.dart';
import '../../components/app_header.dart';

class FoodDetailScreen extends StatelessWidget {
  final String category;

  const FoodDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final itemsData = ItemsData();
    final foodItems = itemsData.getFoodItems(category);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                backButton: BackButton(
                  color: Colors.white,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                title: category,
                rightWidget: IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                ),
                subtitle: null,
              ),
              // Food Items List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: foodItems.length,
                    itemBuilder: (context, index) {
                      final item = foodItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: FoodItemCard(key: ValueKey(item['name']), item: item),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

