import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app_theme.dart';
import 'package:news_app/screens/auth.dart';
import 'package:news_app/screens/first_screen.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/tabs.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //when app freezes after firbase intialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
        const ProviderScope(
      child: MyApp(),
    ));
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
      home: StreamBuilder(stream:  FirebaseAuth.instance.authStateChanges(),builder: (ctx, snapshot) {
            if (snapshot.hasData) {
             return const TabsScreen();
            }

            return const AuthScreen();
          }),);
     //  const TabsScreen(),
  
  }
}
