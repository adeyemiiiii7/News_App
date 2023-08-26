import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/pages/search_screen.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/search_file.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider).newsModel;
    final isLoading = ref.watch(newsProvider).isLoading;
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Scaffold(
      backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor:  appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white12,
        title:  Text("Breaking News for Today",
        style: GoogleFonts.poppins(
          color: Colors.black
        )
        ,),
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
      ]),
      body: SafeArea(
        child: Column(
          children: [
          //  const SearchField(),
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
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor:appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
        onTap: (int index) {
          if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SearchScreen()), // Replace with your search screen
            );
          }
        },
        items:   [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
           backgroundColor:appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
          ),
           BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Search',
          backgroundColor:appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
          ),
        ],
      ),
    );
  }
}
