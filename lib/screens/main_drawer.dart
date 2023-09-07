import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/news_discovery.dart';
import 'package:news_app/screens/tabs.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  @override
  Widget build(BuildContext context) {
     final appThemeState = ref.watch(appThemeStateNotifier);
    return Drawer(
      backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1C1919),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/image/applogo.png',
                  width: 100,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 26,
               color: Color(0xFF1C1919),
            ),
            title: Text(
              'Home',
              style: GoogleFonts.poppins(
                fontSize: 24,
               color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
              ),
            ),
           onTap: (){
             Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabsScreen(),
                ),
              );
            
           },
          ),
          ListTile(
            leading: const Icon(
            Icons.search_sharp ,
              size: 26,
              color: Color(0xFF1C1919),
            ),
            title: Text(
              'Discovery',
              style: GoogleFonts.poppins(
                fontSize: 24,
               color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsDiscoveryScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
               appThemeState.isDarkModeEnable ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
               size: 26,
               ),
               title: Text(
              'Change Theme',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
              ),
            ),
            onTap: (){
               if (appThemeState.isDarkModeEnable) {
                ref.read(appThemeStateNotifier.notifier).setLightTheme();
              } else {
                ref.read(appThemeStateNotifier.notifier).setDarkTheme();
              }
            },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app,
              size: 26,
              ),
              title: Text(
              'LogOut',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {
           FirebaseAuth.instance.signOut();
            },
              
            )
        ],
      ),
    );
  }
}
