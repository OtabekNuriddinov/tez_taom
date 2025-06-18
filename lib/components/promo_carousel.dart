import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'carousel_item.dart';

class PromoCarousel extends StatelessWidget {
  PromoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch for locale changes
    context.locale;
    
    final List<Map<String, dynamic>> _carouselItems = [
      {
        'title': '${'new'.tr()} Gamburger',
        'description': 'special'.tr(),
        'imagePath': 'assets/images/hamburger_image.jpg',
        'color': Colors.orange,
      },
      {
        'title': 'Pizza Promo',
        'description': 'price1pizza2'.tr(),
        'imagePath': 'assets/images/pizza_image.jpg',
        'color': Colors.red,
      },
      {
        'title': 'newDrinks'.tr(),
        'description': 'newDrinks'.tr(),
        'imagePath': 'assets/images/drinks_image.jpg',
        'color': Colors.blue,
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
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
    );
  }
} 