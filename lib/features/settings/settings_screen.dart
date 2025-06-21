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
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final Uri uri = Uri.parse("tel:$phoneNumber");
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('shareAppNotAvailable'.tr()),
        backgroundColor: const Color(0xFF43D049),
        duration: const Duration(seconds: 2),
      ),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicyScreen(),
                                ),
                              );
                            },
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
                            onTap: () => _showTermsOfServiceDialog(context),
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
                            onTap: () => _showRatingDialog(context),
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
            'aboutAppTitle'.tr(),
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
              Text(
                'Tez Taom',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF43D049),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'aboutAppContent'.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'aboutAppFeatures'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF43D049),
                ),
              ),
              const SizedBox(height: 8),
              _buildFeatureItem('aboutAppFeature1'.tr()),
              _buildFeatureItem('aboutAppFeature2'.tr()),
              _buildFeatureItem('aboutAppFeature3'.tr()),
              _buildFeatureItem('aboutAppFeature4'.tr()),
              _buildFeatureItem('aboutAppFeature5'.tr()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ok'.tr(),
                style: const TextStyle(
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

  void _showTermsOfServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'termsOfServiceTitle'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF43D049),
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  'termsOfServiceSection1Title'.tr(),
                  'termsOfServiceSection1Content'.tr(),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'termsOfServiceSection2Title'.tr(),
                  'termsOfServiceSection2Content'.tr(),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'termsOfServiceSection3Title'.tr(),
                  'termsOfServiceSection3Content'.tr(),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'termsOfServiceSection4Title'.tr(),
                  'termsOfServiceSection4Content'.tr(),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'termsOfServiceSection5Title'.tr(),
                  'termsOfServiceSection5Content'.tr(),
                ),
                const SizedBox(height: 20),
                Text(
                  'termsOfServiceLastUpdated'.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ok'.tr(),
                style: const TextStyle(
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

  void _showRatingDialog(BuildContext context) {
    int selectedRating = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'rateAppTitle'.tr(),
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
                  Text(
                    'rateAppSubtitle'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Icon(
                          index < selectedRating ? Icons.star : Icons.star_border,
                          color: const Color(0xFF43D049),
                          size: 40,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'ok'.tr(),
                    style: const TextStyle(
                      color: Color(0xFF43D049),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      if (selectedRating > 0) {
        _showThankYouDialog(context, selectedRating);
      }
    });
  }

  void _showThankYouDialog(BuildContext context, int rating) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'rateAppThankYou'.tr(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFF43D049),
                    size: 30,
                  );
                }),
              ),
              const SizedBox(height: 16),
              Text(
                'rateAppThankYouMessage'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ok'.tr(),
                style: const TextStyle(
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

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF43D049),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
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