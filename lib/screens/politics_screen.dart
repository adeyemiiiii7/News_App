import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/favourites_discover.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_card.dart';

class PoliticsScreen extends ConsumerStatefulWidget {
  const PoliticsScreen({super.key, this.id});

  final Discovery? id;

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
    final MyDiscovery = ref.watch(favoriteDiscoveryOptionsProvider);
    final isFavorite = MyDiscovery.contains(widget.id);

    // Null safety checks
   final id = widget.id;

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
                  : Colors.white,
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
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: appThemeState.isDarkModeEnable
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: appThemeState.isDarkModeEnable
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                if (id != null) {
                      final wasAdded = ref
                          .read(favoriteDiscoveryOptionsProvider.notifier)
                          .toggleDiscoveryOptionFavoriteStatus(id);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(wasAdded
                            ? 'Discovery added to my list'
                            : 'Discovery removed from my list.'),
                      ));
                }
                    }
                  ,
                )
              ],
            ),
            if (isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
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
          ],
        ),
      ),
    );
  }
}
