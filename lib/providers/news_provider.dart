import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_service.dart';

// This line uses the `part` keyword to indicate that this file will include
// generated code from a corresponding `.freezed.dart` file.
part 'news_provider.freezed.dart';

// The `@freezed` annotation generates code for immutable classes based on
// the annotations within the class.
@freezed
class NewsState with _$NewsState {
  // A factory constructor with named parameters is generated based on this class.
  const factory NewsState({
    @Default(true) bool isLoading, //
    required NewsModel newsModel,
    //@Default(null) dynamic error,
     // R
  }) = _NewsState; // The constructor implementation is generated by Freezed.

  const NewsState._(); // A private constructor, used internally.
}

// A StateNotifier class that manages the state of news in the app.
class NewsNotifier extends StateNotifier<NewsState> {
  // Constructor for NewsNotifier.
  NewsNotifier()
      : super(NewsState(newsModel: NewsModel(results: []), 
      //error: null,
      )) {
    // Initialize the state and load news when the notifier is created.
    loadNews();
  }
  // An asynchronous method to load news from a service.
  loadNews() async {
    // Update the state to indicate that loading is in progress.
    state = state.copyWith(isLoading: true);
    
    // Fetch news data using the NewsService class.
    final newsResponse = await NewsService().fetchNews();
    final news = NewsModel.fromJson(newsResponse);
    
    // Update the state with the fetched news data and set loading to false.
    state = state.copyWith(newsModel: news, isLoading: false);
  }
  loadSearchNews(String title)async{
       state = state.copyWith(isLoading: true);
    
    // Fetch news data using the NewsService class.
    final newsResponse = await NewsService().fetchNewsBySearch(title);
    final news = NewsModel.fromJson(newsResponse);
    
    // Update the state with the fetched news data and set loading to false.
    state = state.copyWith(newsModel: news, isLoading: false);
  }
  loadDiscoveryNews(String id) async {
  state = state.copyWith(isLoading: true);

  dynamic newsResponse;
  
  if (id == 'sports') {
    newsResponse = await NewsService().fetchSportsNews();
  } else if (id == 'entertainment') {
    newsResponse = await NewsService().fetchEntertainment();
  } else if (id == 'technology') {
    newsResponse = await NewsService().fetchTechnology();
  } else if (id == 'politics') {
    newsResponse = await NewsService().fetchPolitics();
  }
  
  final news = NewsModel.fromJson(newsResponse);

  state = state.copyWith(newsModel: news, isLoading: false);
}
}

final newsProvider = StateNotifierProvider<NewsNotifier, NewsState>((ref) => NewsNotifier(),);