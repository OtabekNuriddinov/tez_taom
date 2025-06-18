import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/food_item_card.dart';
import '../../data/food_items.dart';
import '../settings/settings_screen.dart';

class FoodDetailScreen extends StatelessWidget {
  final String category;

  const FoodDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final itemsData = ItemsData();
    final foodItems = itemsData.getFoodItems(category);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
        title: Text(
          category,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return FoodItemCard(key: ValueKey(item['name']), item: item);
        },
      ),
    );
  }
}

