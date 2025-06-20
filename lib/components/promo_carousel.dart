import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'carousel_item.dart';

class PromoCarousel extends StatelessWidget {
  PromoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    
    final List<Map<String, dynamic>> _carouselItems = [
      {
        'title': '${'new'.tr()} Hamburger',
        'description': 'special'.tr(),
        'imagePath': 'assets/images/hamburger_image.jpg',
        'color': isDark ? Colors.orange[300]! : Colors.orange[600]!,
      },
      {
        'title': 'Pizza Promo',
        'description': 'price1pizza2'.tr(),
        'imagePath': 'assets/images/pizza_image.jpg',
        'color': isDark ? Colors.red[300]! : Colors.red[600]!,
      },
      {
        'title': 'newDrinks'.tr(),
        'description': 'newDrinks'.tr(),
        'imagePath': 'assets/images/drinks_image.jpg',
        'color': isDark ? Colors.blue[300]! : Colors.blue[600]!,
      },
    ];

    return FlutterCarousel(
      items: _carouselItems.map((item) {
        return CarouselItem(
          title: item['title'] as String,
          description: item['description'] as String,
          imagePath: item['imagePath'] as String,
          color: item['color'] as Color,
        );
      }).toList(),
      options: CarouselOptions(
        height: 160.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.easeInOutCubic,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        // showIndicator: true, // If supported in your version
      ),
    );
  }
} 