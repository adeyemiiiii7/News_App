import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/data_sources/discovery_options.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/widgets/news_grid.dart';

class NewsDiscoveryScreen extends ConsumerWidget {
  const NewsDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final appThemeState = ref.watch(appThemeStateNotifier);
    return Scaffold(
       backgroundColor: appThemeState.isDarkModeEnable ? const Color.fromARGB(255, 28, 25, 25) : Colors.white,
      appBar: AppBar(
         backgroundColor: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25) : Colors.white12,
        title: const Text('Pick A News Discovery'),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for(final discovery in availableDiscovery)
          NewsGridItem(discovery: discovery),
        ],
        )
    );
  }
}