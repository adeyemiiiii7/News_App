import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:news_app/widgets/search_file.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider).newsModel;
    final isLoading = ref.watch(newsProvider).isLoading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(190, 208, 207, 207),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Breaking News for Today"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             // const SearchField(),
          isLoading
              ? SizedBox(
                height: MediaQuery.of(context).size.height /2,
                child: const Center(
                    child: CircularProgressIndicator(),
                  ),
              )
              : ListView.builder(
                  itemCount: news.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NewsCard(article: news.results![index]);
                  },
                ),
            ],
              ),
        ),
      ),
    );
  }
}
