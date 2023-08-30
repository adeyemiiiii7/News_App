import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_card.dart';


class TechnologyScreen extends ConsumerStatefulWidget {
  const TechnologyScreen({super.key});

  @override
  _TechnologyScreenState createState() => _TechnologyScreenState();
}

class _TechnologyScreenState extends ConsumerState<TechnologyScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(newsProvider.notifier).loadDiscoveryNews('technology');
    });
  }
  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final isLoading = ref.watch(newsProvider).isLoading;
    final news = ref.watch(newsProvider).newsModel;
    return Scaffold(
       backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white12,
        title: Text(
          "Technology News",
          style: GoogleFonts.poppins(
            color: appThemeState.isDarkModeEnable ? Colors.white : Colors.grey[900],
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(appThemeState.isDarkModeEnable ? Icons.lightbulb : Icons.lightbulb_outline),
        //     onPressed: () {
        //       if (appThemeState.isDarkModeEnable) {
        //         ref.read(appThemeStateNotifier.notifier).setLightTheme();
        //       } else {
        //         ref.read(appThemeStateNotifier.notifier).setDarkTheme();
        //       }
        //     },
        //   ),
        // ],
      ),
           body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
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
    );
  }
}