import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';
import '../../components/app_background.dart';
import '../../components/app_header.dart';
import '../../components/app_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch phone call')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching phone call: $e')),
        );
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch URL')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching URL: $e')),
        );
      }
    }
  }

  void _shareApp() {
    Share.share(
      'Check out this amazing food delivery app: Tez Taom!',
      subject: 'Tez Taom - Food Delivery App',
    );
  }

  @override
  Widget build(BuildContext context) {
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
                title: 'settingsTitle'.tr(),
                rightWidget: null,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppCard(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withAlpha(50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Color(0xFF43D049),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'notificationsOption'.tr(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF43D049),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'notificationsDescription'.tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green.withAlpha(150),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _notificationsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _notificationsEnabled = value;
                                  });
                                },
                                activeColor: const Color(0xFF43D049),
                                activeTrackColor: Colors.green.withAlpha(80),
                                inactiveThumbColor: Colors.green.withAlpha(120),
                                inactiveTrackColor: Colors.green.withAlpha(30),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.language, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('languageOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _showLanguageDialog(context),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.info_outline, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('aboutAppOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: Text('aboutAppDescription'.tr(), style: TextStyle(color: Colors.green.withAlpha(150))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _showAboutAppDialog(context),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.privacy_tip_outlined, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('privacyPolicyOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: Text('privacyPolicyDescription'.tr(), style: TextStyle(color: Colors.green.withAlpha(150))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _launchUrl('https://example.com/privacy'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.description_outlined, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('termsOfServiceOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: Text('termsOfServiceDescription'.tr(), style: TextStyle(color: Colors.green.withAlpha(150))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _launchUrl('https://example.com/terms'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.star_outline, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('rateAppOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: Text('rateAppDescription'.tr(), style: TextStyle(color: Colors.green.withAlpha(150))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.example.tez_taom'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.share, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('shareAppOption'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: Text('shareAppDescription'.tr(), style: TextStyle(color: Colors.green.withAlpha(150))),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: _shareApp,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppCard(
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.phone, color: Color(0xFF43D049), size: 24),
                            ),
                            title: Text('contactUs'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                            subtitle: const Text('+998947073980', style: TextStyle(color: Colors.black54)),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF43D049), size: 20),
                            onTap: () => _launchPhone('+998947073980'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return AppCard(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withAlpha(50),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(Icons.info_outline, color: Color(0xFF43D049), size: 24),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('appVersion'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF43D049))),
                                          const SizedBox(height: 4),
                                          Text('v${snapshot.data!.version}', style: const TextStyle(color: Colors.black54)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 32),
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

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'selectLanguage'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF43D049),
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context,
                'assets/flags/uzbekistan.png',
                'uzbekLanguage'.tr(),
                const Locale('uz', 'UZ'),
              ),
              const Divider(color: Color(0xFF43D049), height: 1),
              _buildLanguageOption(
                context,
                'assets/flags/russia.png',
                'russianLanguage'.tr(),
                const Locale('ru', 'RU'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'aboutAppOption'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF43D049),
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tez Taom',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF43D049),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fast food delivery application with a wide selection of dishes. Order your favorite food quickly and easily!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Features:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF43D049),
                ),
              ),
              const SizedBox(height: 8),
              _buildFeatureItem('• Fast delivery'),
              _buildFeatureItem('• Wide selection of dishes'),
              _buildFeatureItem('• Easy ordering process'),
              _buildFeatureItem('• Multiple payment options'),
              _buildFeatureItem('• Real-time order tracking'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF43D049),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String flagAsset,
    String languageName,
    Locale locale,
  ) {
    final isSelected = context.locale == locale;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? const Color(0xFF43D049).withAlpha(40) : Colors.transparent,
      ),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF43D049),
              width: 1,
            ),
          ),
          child: Image.asset(
            flagAsset,
            width: 30,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          languageName,
          style: const TextStyle(
            color: Color(0xFF43D049),
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Color(0xFF43D049), size: 24)
            : null,
        onTap: () {
          context.setLocale(locale);
          Navigator.pop(context);
        },
      ),
    );
  }
} 