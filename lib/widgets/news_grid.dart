import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/entertainment_screen.dart';
import 'package:news_app/screens/politics_screen.dart';
import 'package:news_app/screens/sport_screen.dart';
import 'package:news_app/screens/technology_screen.dart';


class NewsGridItem extends ConsumerWidget {
  const NewsGridItem({
    Key? key,
    required this.discovery,
  }) : super(key: key);

  final Discovery discovery;

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
        }
        },
        );
      
   //  backgroundColors: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white;
      },
borderRadius: BorderRadius.circular(16),
// child: Container(
//   padding: const EdgeInsets.all(16),
//   decoration: BoxDecoration(
//    borderRadius: BorderRadius.circular(7),
//      color: Colors.white54
//   ),
  
  child: Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(7),
        color: Colors.white60
    ),
    child: Center(
      child: Text(
        discovery.title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25) : Colors.white,
            ),
      ),
    ),
  ),
);
        
      
  }
}
