import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/my_discovery.dart';
import 'package:news_app/screens/tabs.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainDrawerState();
}

String getGreeting() {
  final currentTime = DateTime.now();
  final hour = currentTime.hour;

  if (hour < 12) {
    return 'Good Morning...';
  } else if (hour < 18) {
    return 'Good Afternoon...';
  } else {
    return 'Good Evening...';
  }
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return Drawer(
      shadowColor: Colors.black,
      backgroundColor:
          appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
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
          // ListTile(
          //     Text(getGreeting()),
          // ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 26,
              color:
                  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search_sharp,
              size: 26,
              color:
                  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            ),
            title: Text(
              'Discovery',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              appThemeState.isDarkModeEnable
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              size: 26,
              color:
                  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            ),
            title: Text(
              'Change Theme',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              if (appThemeState.isDarkModeEnable) {
                ref.read(appThemeStateNotifier.notifier).setLightTheme();
              } else {
                ref.read(appThemeStateNotifier.notifier).setDarkTheme();
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 26,
              color:
                  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            ),
            title: Text(
              'LogOut',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_border,
              size: 26,
              color:
                  appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
            ),
            title: Text(
              'My Discoveries',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoriteDiscoveryScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}
