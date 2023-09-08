import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_card.dart';


class EntertainmentScreen extends ConsumerStatefulWidget {
  const EntertainmentScreen({super.key});

  @override
  _EntertainmentScreenState createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends ConsumerState<EntertainmentScreen> {
  @override
   void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(newsProvider.notifier).loadDiscoveryNews('entertainment',);
    });
  }
   Future<void> _refreshNewsData() async {
    await ref.read(newsProvider.notifier).loadDiscoveryNews('entertainment',);
    ref.read(newsProvider.notifier).loadDiscoveryNews('entertainment');
  }
  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final isLoading = ref.watch(newsProvider).isLoading;
    final news = ref.watch(newsProvider).newsModel;
    return Scaffold(
       backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25) : Colors.white,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25): Colors.white12,
        title: Text(
          "Entertainment News",
          style: GoogleFonts.poppins(
            color: appThemeState.isDarkModeEnable ? Colors.white :  const Color.fromARGB(255, 28, 25, 25),
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
        child: Stack(
          children: [
            Column(
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
                    child: RefreshIndicator(
                        onRefresh: _refreshNewsData, // Call the refresh function here
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: news.results!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NewsCard(article: news.results![index]);
                            },
                          ),
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