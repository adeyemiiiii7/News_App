import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/favourites_discover.dart';
import 'package:news_app/widgets/favorite_discovery.dart';

class FavoriteDiscoveryScreen extends ConsumerWidget {
  const FavoriteDiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteDiscoveryOptions = ref.watch(favoriteDiscoveryOptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News Discovery'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: favoriteDiscoveryOptions.length,
        itemBuilder: (context, index) {
          final discovery = favoriteDiscoveryOptions[index];
          return DiscoveryOptionTile( discovery: discovery,);
        },
      ),
    );
  }
}
