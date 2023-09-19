//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/constants/constants.dart';

class NewsService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      responseType: ResponseType.json,
    ),
  );
  
  Future<dynamic> fetchNews() async {
    var response = await _dio.get('news?language=en&category=world&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchNextPage(int page) async {
  var response = await _dio.get(
      'news?language=en&category=world&page=$page&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
  return response.data;
}


  Future<dynamic> fetchNewsBySearch(String title) async {
    var response = await _dio.get('everything?q=$title&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }

  Future<dynamic> fetchSportsNews() async {
    var response = await _dio.get('news?language=en&category=sports&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchEntertainment() async{
     var response = await _dio.get('news?language=en&category=entertainment&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchTechnology() async {
     var response = await _dio.get('news?language=en&category=technology&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
   Future<dynamic> fetchPolitics() async {
     var response = await _dio.get('news?language=en&category=politics&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchHealth() async {
     var response = await _dio.get('news?language=en&category=health&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchWorld() async {
     var response = await _dio.get('news?language=en&category=world&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
Future<dynamic> fetchBussiness() async {
     var response = await _dio.get('news?language=en&category=business&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
Future<dynamic> fetchTopNews() async {
     var response = await _dio.get('news?language=en&category=top&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
}
  Future<dynamic> fetchTourisms() async {
     var response = await _dio.get('news?language=en&category=tourism&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
  Future<dynamic> fetchNigeriaHeadlines() async {
     var response = await _dio.get('news?language=en&country=ng&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }


}