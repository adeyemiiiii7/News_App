import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/main_drawer.dart';
import 'package:news_app/widgets/news_card.dart';

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

  Future<void> _refreshNewsData() async {
    // Call the function to reload your news data here.
    await ref.read(newsProvider.notifier).loadNews();

    // Notify Riverpod to rebuild the UI by reading the news data again.
   ref.read(newsProvider); // This will trigger a rebuild.
  }

  @override
  Widget build(BuildContext context) {
    final news = ref.watch(newsProvider).newsModel;
    final isLoading = ref.watch(newsProvider).isLoading;
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Scaffold(
      backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25) : Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25): Colors.white12,
        
        title: Text(
          "Headlines for Today",
          style: GoogleFonts.poppins(
            color: appThemeState.isDarkModeEnable ? Colors.white : const Color.fromARGB(255, 28, 25, 25),
          ),
        ),
        centerTitle: true,
        
        // actions: const [
        
        //   // IconButton(
        //   //   icon: Icon(appThemeState.isDarkModeEnable ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
        //   //   onPressed: () {
        //   //     if (appThemeState.isDarkModeEnable) {
        //   //       ref.read(appThemeStateNotifier.notifier).setLightTheme();
        //   //     } else {
        //   //       ref.read(appThemeStateNotifier.notifier).setDarkTheme();
        //   //     }
        //   //   },
        //   // ),
        // ],
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                        child: RefreshIndicator(
                  onRefresh: _refreshNewsData, // Call the refresh function here
                 child: ListView.builder(
              itemCount: news.results!.length,
              itemBuilder: (BuildContext context, int index) {
              return NewsCard(article: news.results![index]);
                          },
                        ),
                      ),
                    ),
              ],
            
            ),
      
          ],
        ),
      ),
    );
  }
}
