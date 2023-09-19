import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/favourites_discover.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/favorite_discovery.dart';

class FavoriteDiscoveryScreen extends ConsumerWidget {
  const FavoriteDiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteDiscoveryOptions = ref.watch(favoriteDiscoveryOptionsProvider);
       final appThemeState = ref.watch(appThemeStateNotifier);
    return Scaffold(
      body: CustomScrollView(
       slivers: [
          SliverAppBar(
            backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25) : Colors.white12,
            title: Text('Pick A News Discovery',
             style: GoogleFonts.poppins(
                color: appThemeState.isDarkModeEnable
                    ? Colors.white
                    : const Color.fromARGB(255, 28, 25, 25),
              ),
            ),
            centerTitle: true,
            floating: false, // Set to true if you want it to become the app bar when scrolling down.
            pinned: true,   // Set to true if you want it to stay at the top even when scrolling down.
          ),
         SliverPadding(
        padding: const EdgeInsets.all(24),
        sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final discovery = favoriteDiscoveryOptions[index];
          return DiscoveryOptionTile( discovery: discovery,);
        },
        childCount:     favoriteDiscoveryOptions.length,
      ),
        ),
         ),
       ],
      ),
    );
  }
}
