import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/theme_provider.dart';


class NewsGridItem extends ConsumerWidget {
  const NewsGridItem({super.key,
  required this.discovery});
   final Discovery discovery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final appThemeState = ref.watch(appThemeStateNotifier);
    return InkWell(
         onTap: () {},
      splashColor:  appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                discovery.color.withOpacity(0.55),
                discovery.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
           discovery.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: appThemeState.isDarkModeEnable ? Colors.grey[900] : Colors.white,
              ),
        ),
      ),
    );
  }
}

