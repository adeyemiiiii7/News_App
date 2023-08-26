import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/pages/home_screen.dart';
import 'package:news_app/pages/tabs.dart';
import 'package:news_app/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp(),));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppThemeState = ref.watch(appThemeStateNotifier);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: TabsScreen(),
    );
  }
}