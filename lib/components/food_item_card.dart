import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../features/order/order_confirmation_screen.dart';
import '../providers/cart_provider.dart';

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

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              widget.item['imagePath'] as String,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item['description'] as String,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'sizesTitle'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ...(widget.item['sizes'] as List).asMap().entries.map((entry) {
                  final index = entry.key;
                  final size = entry.value;
                  return RadioListTile<int>(
                    title: Text(
                      size['name'] as String,
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      '${size['price']} so\'m',
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: index,
                    groupValue: _selectedSizeIndex,
                    onChanged: (value) {
                      setState(() {
                        _selectedSizeIndex = value!;
                      });
                    },
                  );
                }).toList(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: Text('orderButton'.tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}