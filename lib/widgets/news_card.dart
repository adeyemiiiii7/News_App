import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/theme_provider.dart';

class NewsCard extends ConsumerWidget {
  const NewsCard({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final appThemeState = ref.watch(appThemeStateNotifier);
    return Container(
      padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
        color: appThemeState.isDarkModeEnable ?  const Color.fromARGB(255, 28, 25, 25) : Colors.white,
             // Adjust colors for dark and light themes
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl == null ? 
                  ApiUrls.imageNotFound : article.imageUrl.toString(),
                  errorWidget: (context, string, _) {
                    return const Icon(Icons.error);
                  },
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                )
              ),
              const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    article.title.toString(),
                    style:  GoogleFonts.poppins(
                  color: appThemeState.isDarkModeEnable ? Colors.white : Colors.black,
                     // fontWeight: FontWeight.bold
  
                    ),
                  ),
                )
            ],
          ),
    );
  }
  }
