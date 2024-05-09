import 'package:dio/dio.dart';
class DioHelper{
  static late Dio dio;
  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'http://192.168.43.142:8000/api/',//url project
          receiveDataWhenStatusError: true,
          // headers: {
          //   'Content-Type':'application/json',
          //   //'lang':'en', language
          // }
        )
    );
  }
  static Future<Response>getData({
    required String url,
    query,
    String?  token,
  })
  async{
    dio.options.headers={
      'Content-Type':'application/json',
      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };

    return await dio.get(url,queryParameters:query,);
  }


  static Future<Response> postData(
      {required String url,
        query,
        required Map<String,dynamic>data,
       // String lang ='en',
       String?  token,
      }) async {

    dio.options.headers={

      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };
    //Response response =await dio.post(url, queryParameters: query,data: data);

    return dio.post(url, queryParameters: query,data: data);
  }


  static Future<Response> putData(
      {required String url,
        query,
        required Map<String,dynamic>data,
        String lang ='en',
        String?  token,
      }) async {
    dio.options.headers={
      'Content-Type':'application/json',

      'Authorization':token,
    };

    return dio.put(url, queryParameters: query,data: data);
  }

static Future<Response>getDataSingOut({
required String url,
query,
String?  token,
})
async{
dio.options.headers={

'Accept':'application/json',
 "Authorization":"Bearer $token",
};

return await dio.post(url,queryParameters:query,);
}
static Future<Response> patchData(
{required String url,

required Map<String,dynamic>data,

}) async {
dio.options.headers={

'Accept':'application/json',
//'Authorization':token,
};

return dio.patch(url,data: data);
}




  static Future<Response> postDataPharmacy(
      {required String url,
        query,
        required FormData data,
        // String lang ='en',
        String?  token,
      }) async {

    dio.options.headers={
      'Content-type':'application/json',
      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };
    //Response response =await dio.post(url, queryParameters: query,data: data);

    return dio.post(url, queryParameters: query,data: data);
  }

  static Future<Response> postDataUser(
      {required String url,
        query,

        // String lang ='en',
        String?  token,
      }) async {

    dio.options.headers={

      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };
    //Response response =await dio.post(url, queryParameters: query,data: data);

    return dio.post(url, queryParameters: query);
  }

  static Future<Response> delete(
      {required String url,
        query,
        required Map<String,dynamic>data,

        String?  token,
      }) async {

    dio.options.headers={

      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };
    //Response response =await dio.post(url, queryParameters: query,data: data);

    return dio.delete(url, queryParameters: query,data: data);
  }
  static Future<Response>getData2({
    required String url,
    String?  token,
  })
  async{
    dio.options.headers={
      'Content-Type':'application/json',
      'Accept':'application/json',
      "Authorization":"Bearer $token",
    };

    return await dio.get(url,);
  }
}