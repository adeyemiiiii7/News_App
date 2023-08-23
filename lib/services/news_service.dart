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

  Future<dynamic> fetchNewsBySearch(String title) async {
   var response = await _dio.get('everything?q=$title&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');
    return response.data;
  }
}
