import 'package:buylike/provider/provider.dart';
import 'package:buylike/screen/splash_screen.dart';
import 'package:buylike/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(),
      child: MaterialApp(
        title: 'BuyLike',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
         home: const SplashScreen(),
      ),
    );
  }
}
