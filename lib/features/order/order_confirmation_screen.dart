import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/telegram_service.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../home/menu_screen.dart';
import '../settings/settings_screen.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  final TelegramService _telegramService = TelegramService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendOrderToTelegram() async {
    if (!_formKey.currentState!.validate()) return;

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    if (cartProvider.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('cartEmpty'.tr()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final message = '''
🆕 Yangi buyurtma!

${cartProvider.cartItems.map((item) => '''
🍽️ ${item['name']}
📝 ${item['description']}
📏 O'lcham: ${item['size']}
💰 Narx: ${item['price']} so'm
🔢 Soni: ${item['quantity']}
💵 Umumiy: ${item['total']} so'm
''').join('\n')}

👤 Mijoz ma'lumotlari:
📱 Telefon: ${_phoneController.text}
📍 Manzil: ${_addressController.text}

💵 Umumiy buyurtma narxi: ${cartProvider.totalCartPrice} so'm
⏰ Buyurtma vaqti: ${DateTime.now().toString().substring(0, 16)}
''';

    try {
      final response = await _telegramService.sendMessage(message);

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('orderSentSuccess'.tr()),
              backgroundColor: Colors.green,
            ),
          );
          cartProvider.clearCart();
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('errorOccurred'.tr() + ': ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('checkInternet'.tr() + ': $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
          'orderConfirmation'.tr(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'cartTitle'.tr(),
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      cartProvider.cartItems.isEmpty
                          ? Center(
                              child: Text(
                                'cartEmpty'.tr(),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartProvider.cartItems.length,
                              itemBuilder: (context, index) {
                                final item = cartProvider.cartItems[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            item['name'] as String,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['size'] as String,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                '${item['total']} so\'m',
                                                style: GoogleFonts.poppins(
                                                  color: Theme.of(context).colorScheme.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete_outline),
                                            onPressed: () => cartProvider.removeItem(index),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () => cartProvider.updateItemQuantity(
                                                index,
                                                (item['quantity'] as int) - 1,
                                              ),
                                              icon: const Icon(Icons.remove_circle_outline),
                                            ),
                                            Text(
                                              '${item['quantity']}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => cartProvider.updateItemQuantity(
                                                index,
                                                (item['quantity'] as int) + 1,
                                              ),
                                              icon: const Icon(Icons.add_circle_outline),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'totalPrice'.tr() + ':',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${cartProvider.totalCartPrice} so\'m',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                child: Text('addMoreItems'.tr()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'phoneNumber'.tr(),
                  hintText: '+998 XX XXX XX XX',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enterPhoneNumber'.tr();
                  }
                  if (!RegExp(r'^\+998\s?\d{2}\s?\d{3}\s?\d{2}\s?\d{2}$')
                      .hasMatch(value)) {
                    return 'invalidPhoneNumber'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'address'.tr(),
                  hintText: 'enterAddress'.tr(),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.location_on),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'invalidAddress'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _sendOrderToTelegram,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('confirmOrder'.tr()),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
} 