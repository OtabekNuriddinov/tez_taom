import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/telegram_service.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../home/menu_screen.dart';
import '../settings/settings_screen.dart';
import '../../components/app_background.dart';
import '../../components/app_header.dart';
import '../../components/app_card.dart';
import '../../components/app_button.dart';

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
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
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
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: 'orderConfirmation'.tr(),
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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'cartTitle'.tr(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF43D049),
                                ),
                              ),
                              const SizedBox(height: 16),
                              cartProvider.cartItems.isEmpty
                                  ? Center(
                                      child: Text(
                                        'cartEmpty'.tr(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: cartProvider.cartItems.length,
                                      itemBuilder: (context, index) {
                                        final item = cartProvider.cartItems[index];
                                        return _buildCartItemCard(
                                          item: item,
                                          index: index,
                                          cartProvider: cartProvider,
                                        );
                                      },
                                    ),
                              if (cartProvider.cartItems.isNotEmpty) ...[
                                const Divider(color: Color(0xFF43D049)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Umumiy narx:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF43D049),
                                      ),
                                    ),
                                    Text(
                                      '${cartProvider.totalCartPrice} so\'m',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF43D049),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,),
                          child: AppButton(
                            text: 'addMoreItems'.tr(),
                            onPressed: () => Navigator.pop(context),
                            outlined: true,
                          ),
                        ),
                        const SizedBox(height: 18),
                        AppCard(
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: _phoneController,
                                labelText: 'phoneNumber'.tr(),
                                hintText: '+998 XX XXX XX XX',
                                prefixIcon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'enterPhoneNumber'.tr();
                                  }
                                  if (!RegExp(r'^\+998\s?\d{2}\s?\d{3}\s?\d{2}\s?\d{2}$').hasMatch(value)) {
                                    return 'invalidPhoneNumber'.tr();
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              _buildTextField(
                                controller: _addressController,
                                labelText: 'address'.tr(),
                                hintText: 'enterAddress'.tr(),
                                prefixIcon: Icons.location_on,
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'invalidAddress'.tr();
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: AppButton(
                            text: 'confirmOrder'.tr(),
                            onPressed: _sendOrderToTelegram,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItemCard({
    required Map<String, dynamic> item,
    required int index,
    required CartProvider cartProvider,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                item['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF43D049),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['size'] as String,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    '${item['total']} so\'m',
                    style: const TextStyle(
                      color: Color(0xFF43D049),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
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
                  icon: const Icon(Icons.remove_circle_outline, color: Color(0xFF43D049)),
                ),
                Text(
                  '${item['quantity']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF43D049),
                  ),
                ),
                IconButton(
                  onPressed: () => cartProvider.updateItemQuantity(
                    index,
                    (item['quantity'] as int) + 1,
                  ),
                  icon: const Icon(Icons.add_circle_outline, color: Color(0xFF43D049)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Color(0xFF43D049)),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: Color(0xFF43D049)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF43D049)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF43D049), width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF43D049)),
        hintStyle: const TextStyle(color: Colors.black38),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
} 