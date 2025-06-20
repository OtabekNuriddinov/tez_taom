import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

import '../features/order/order_confirmation_screen.dart';
import '../providers/cart_provider.dart';
import 'dart:ui';

class FoodItemCard extends StatefulWidget {
  final Map<String, dynamic> item;

  const FoodItemCard({super.key, required this.item});

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  int _selectedSizeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedSize = widget.item['sizes'][_selectedSizeIndex];
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.withAlpha(60),
          width: 1.5,
        ),
        color: Colors.white.withAlpha(200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              widget.item['imagePath'] as String,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item['description'] as String,
                  style: GoogleFonts.poppins(
                    color: Colors.green.withAlpha(150),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'sizesTitle'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 8),
                ...(widget.item['sizes'] as List).asMap().entries.map((entry) {
                  final index = entry.key;
                  final size = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedSizeIndex == index
                            ? Colors.green[600]!
                            : Colors.green.withAlpha(60),
                        width: 1.5,
                      ),
                      color: _selectedSizeIndex == index
                          ? Colors.green.withOpacity(0.08)
                          : Colors.white.withOpacity(0.7),
                    ),
                    child: RadioListTile<int>(
                      title: Text(
                        size['name'] as String,
                        style: GoogleFonts.poppins(
                          color: Colors.green[700],
                        ),
                      ),
                      subtitle: Text(
                        '${size['price']} so\'m',
                        style: GoogleFonts.poppins(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: index,
                      groupValue: _selectedSizeIndex,
                      activeColor: Colors.green[600],
                      onChanged: (value) {
                        setState(() {
                          _selectedSizeIndex = value!;
                        });
                      },
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.green.withAlpha(60),
                      width: 1.5,
                    ),
                    color: Colors.green[600],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final itemToAdd = {
                          'name': widget.item['name'],
                          'description': widget.item['description'],
                          'imagePath': widget.item['imagePath'],
                          'size': selectedSize['name'],
                          'price': selectedSize['price'],
                          'quantity': 1,
                          'total': selectedSize['price'] * 1,
                        };
                        cartProvider.addItem(itemToAdd);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderConfirmationScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'orderButton'.tr(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}