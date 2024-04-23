import 'package:flutter/material.dart';
import 'package:myapp/config/theme/dark_mode.dart';
import 'package:myapp/config/theme/light_mode.dart';
import 'package:myapp/config/theme/theme_provider.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ,
    );
  }
} 