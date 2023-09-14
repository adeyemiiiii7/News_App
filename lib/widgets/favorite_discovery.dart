import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/favourites_discover.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/entertainment_screen.dart';
import 'package:news_app/screens/health_screen.dart';
import 'package:news_app/screens/nigeria_headline_screen.dart';
import 'package:news_app/screens/politics_screen.dart';
import 'package:news_app/screens/sport_screen.dart';
import 'package:news_app/screens/technology_screen.dart';
import 'package:news_app/screens/top_news_screen.dart';
import 'package:news_app/screens/tourism_screen.dart';
import 'package:news_app/screens/world_screen.dart'; // Import your provider for favorite discovery options here

class DiscoveryOptionTile extends ConsumerWidget {
  const DiscoveryOptionTile({
    Key? key,
  //  required this.discoveryOption,
    required this.discovery
  }) : super(key: key);

  //final DiscoveryOption discoveryOption;
   final Discovery  discovery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);

    return InkWell(
      onTap: () {
     Future.microtask(() {
          // Future.microtask, you're ensuring that the provider modifications are delayed until after
          // the widget tree has finished building, which should help resolve the error you were encountering.

          if (discovery.id == 'sports') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SportScreen(),
              ),
            );
          } else if (discovery.id == 'entertainment') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EntertainmentScreen(),
              ),
            );
          } else if (discovery.id == 'politics') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PoliticsScreen(),
              ),
            );
          } else if (discovery.id == 'technology') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TechnologyScreen(),
              ),
            );
          } else if (discovery.id == 'business') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BusinesssScreen(),
              ),
            );
          } else if (discovery.id == 'health') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HealthScreen(),
              ),
            );
          } else if (discovery.id == 'top_news') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TopNewsScreen(),
              ),
            );
          } else if (discovery.id == 'tourism') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TourismsScreen(),
              ),
            );
          } else if (discovery.id == 'world') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WorldNewsScreen(),
              ),
            );
          } else if (discovery.id == 'nigeria_headlines') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NigeriaHeadlineScreen(),
              ),
            );
          }
        });

      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: appThemeState.isDarkModeEnable
              ? Colors.white60
              : const Color.fromARGB(255, 28, 25, 25),
        ),
        child: Center(
          child: Text(
            discovery.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: appThemeState.isDarkModeEnable
                      ? const Color.fromARGB(255, 28, 25, 25)
                      : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
