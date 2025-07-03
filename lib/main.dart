import 'package:flutter/material.dart';
import 'package:profile_provider_static/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'providers/profile_provider.dart';
import 'screens/list_profile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return MaterialApp(
      title: 'Profile App',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: ListProfile(),
    );
  }
}
