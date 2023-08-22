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
      var respone = await _dio.get('&q=news%2024');

      return respone.data;

    }
}