import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch phone call')),
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'settingsTitle'.tr(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dark/Light Theme Switch
            ListTile(
              title: Text(
                'themeOption'.tr(),
                style: GoogleFonts.poppins(),
              ),
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
            const Divider(),
            // Language Selection Button
            ListTile(
              title: Text(
                'languageOption'.tr(),
                style: GoogleFonts.poppins(),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
            const Divider(),
            ListTile(
              title: Text('contactUs'.tr()),
              subtitle: const Text('+998947073980'),
              trailing: const Icon(Icons.phone),
              onTap: () => _launchPhone('+998947073980'),
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text('appVersion'.tr()),
                    subtitle: Text(snapshot.data!.version),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'selectLanguage'.tr(),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                selected: context.locale == const Locale('uz', 'UZ'),
                selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                leading: Image.asset(
                  'assets/flags/uzbekistan.png',
                  width: 30,
                ),
                title: Text(
                  'uzbekLanguage'.tr(),
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  context.setLocale(const Locale('uz', 'UZ'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selected: context.locale == const Locale('ru', 'RU'),
                selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                leading: Image.asset(
                  'assets/flags/russia.png',
                  width: 30,
                ),
                title: Text(
                  'russianLanguage'.tr(),
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  context.setLocale(const Locale('ru', 'RU'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 