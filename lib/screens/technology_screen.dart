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

  Future<void> _refreshNewsData() async {
    ref.read(newsProvider.notifier).loadDiscoveryNews('technology');
  }

  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final isLoading = ref.watch(newsProvider).isLoading;
    final news = ref.watch(newsProvider).newsModel;
    
    return Scaffold(
      backgroundColor: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25) : Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25) : Colors.white12,
        title: Text(
          "Technology News",
          style: GoogleFonts.poppins(
            color: appThemeState.isDarkModeEnable ? Colors.white :  const Color.fromARGB(255, 28, 25, 25),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                // Add your greeting text here
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
      ),
    );
  }
}
