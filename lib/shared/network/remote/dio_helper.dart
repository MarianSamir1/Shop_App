import 'package:dio/dio.dart';

class DioHelper{

  static late Dio dio;

  static init(){
    dio = Dio( 
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,
        followRedirects: false
        )
    );
  }

  //GET
 static Future<Response> getData({
    required String url,
    Map<String , dynamic>? query,
    String lang ='en',
    String? token 
  })async
  {
     dio.options.headers = 
     {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization': token??''
    };
   return await dio.get(url , queryParameters: query);
  }

  //POST 
   static Future<Response> postData({
    required String url,
    required Map<String , dynamic> data,
    Map<String , dynamic>? query,
    String? token ,
    String lang = 'en'
  })async
  {
    dio.options.headers = 
    {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization': token??''
    };
   return await dio.post(
     url,
     data: data,
     queryParameters: query
   );
  }

  //POST 
   static Future<Response> putData({
    required String url,
    required Map<String , dynamic> data,
    Map<String , dynamic>? query,
    String? token ,
    String lang = 'en'
  })async
  {
    dio.options.headers = 
    {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization': token??''
    };
   return await dio.put(
     url,
     data: data,
     queryParameters: query
   );
  }
}