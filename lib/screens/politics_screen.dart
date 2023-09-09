import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
//import 'package:news_app/screens/next_page.dart';
import 'package:news_app/widgets/news_card.dart';


class PoliticsScreen extends ConsumerStatefulWidget {
  const PoliticsScreen({super.key});

  @override
  _PoliticsScreenState createState() => _PoliticsScreenState();
}

class _PoliticsScreenState extends ConsumerState<PoliticsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(newsProvider.notifier).loadDiscoveryNews('politics');
    });
  }
   Future<void> _refreshNewsData() async {
    ref.read(newsProvider.notifier).loadDiscoveryNews('politics');
  }

  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    final isLoading = ref.watch(newsProvider).isLoading;
    final news = ref.watch(newsProvider).newsModel;
    return Scaffold(
      backgroundColor: appThemeState.isDarkModeEnable
          ? const Color.fromARGB(255, 28, 25, 25)
          : Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshNewsData,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: appThemeState.isDarkModeEnable
                  ? const Color.fromARGB(255, 28, 25, 25)
                  : Colors.white70,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Politics News",
                  style: GoogleFonts.poppins(
                    color: appThemeState.isDarkModeEnable
                        ? Colors.white
                        : const Color.fromARGB(255, 28, 25, 25),
                  ),
                ),
                centerTitle: true,
              ),
            ),
   if (isLoading)
      const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(), // Show CircularProgressIndicator when isLoading is true
        ),
      )
    else
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return NewsCard(article: news.results![index]);
          },
          childCount: news.results!.length,
        ),
      ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: TextButton.icon(
            //         onPressed: () {
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => const NextPage(),
            //             ),
            //           );
            //         },
            //         icon: Icon(
            //           Icons.navigate_next_outlined,
            //           color: appThemeState.isDarkModeEnable
            //               ? Colors.white
            //               : Colors.black,
            //         ),
            //         label: Text(
            //           'Next Page',
            //           style: TextStyle(
            //             color: appThemeState.isDarkModeEnable
            //                 ? Colors.white
            //                 : Colors.black,
            //             fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      )
    );
  }
}
