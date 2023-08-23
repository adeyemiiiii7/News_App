import 'package:dio/dio.dart';
import 'package:news_app/constants/constants.dart';


class NewsService{

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      responseType: ResponseType.json,
    ),
  );
  
    fetchNews() async{
      var respone = await _dio.get('v2/headline?language=en?category=world&apikey=pub_28078ed31faab4e9faa15a14087c40df53ffa');

      return respone.data;

    }


    fetchNewsBySearch(String title) async{  
      var response = await _dio.get('v2/everything?q=$title&apiKey=pub_28078ed31faab4e9faa15a14087c40df53ffa');

      return response.data;
    }
}
