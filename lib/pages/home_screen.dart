import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/search_screen.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/search_file.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
    int _selectedPageIndex = 0;
  // Function to get the appropriate greeting based on the time of day
   void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
   void _setScreen(String identifier) async {
    Navigator.of(context).pop();
     if (identifier == 'filters') {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SearchScreen()
      ),
      );
     }
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

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProvider).newsModel;
    final isLoading = ref.watch(newsProvider).isLoading;
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Scaffold(
      backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white12,
        title: Text(
          "Headlines for Today",
          style: GoogleFonts.poppins(
            color: appThemeState.isDarkModeEnable ? Colors.white : Colors.grey[900],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(appThemeState.isDarkModeEnable ? Icons.lightbulb : Icons.lightbulb_outline),
            onPressed: () {
              if (appThemeState.isDarkModeEnable) {
                ref.read(appThemeStateNotifier.notifier).setLightTheme();
              } else {
                ref.read(appThemeStateNotifier.notifier).setDarkTheme();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  getGreeting(),
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: news.results!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCard(article: news.results![index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      //   onTap: (int index) {
      //     if (index == 1) {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SearchScreen()), // Replace with your search screen
      //       );
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: const Icon(Icons.search),
      //       label: 'Search',
      //       backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      //     ),
      //   ],
      // ),
    );
  }
}
