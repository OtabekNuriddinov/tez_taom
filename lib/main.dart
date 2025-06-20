import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/splash/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('uz', 'UZ'), Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: const Locale('uz', 'UZ'),
        useOnlyLangCode: false,
        assetLoader: const RootBundleAssetLoader(),
        child: const MyApp(),
      ),
    ),
  );
}

