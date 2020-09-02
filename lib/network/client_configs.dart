import 'package:cloudmed_app/common/constants.dart';
import 'package:dio/dio.dart';

class ClientConfigs {
  Dio dio(
      {String token,
      int receiveTimeout: 5000,
      int connectTimeout: 5000,
      int sendTimeout: 5000}) {
    var _dio = Dio();
    _dio.options.baseUrl = Constants.SERVER;
    // add interceptors
    //dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(LogInterceptor());
    //(dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    _dio.options.receiveTimeout = receiveTimeout;
    _dio.options.connectTimeout = connectTimeout;
    _dio.options.sendTimeout = sendTimeout;

    //redirect all status code bellow 500
    _dio.options.followRedirects = false;
    _dio.options.validateStatus = (status) => status < 500;

    if (token != null && token.length != 0)
      _dio.options.headers["Authorization"] = "Bearer " + token;
    //Instance level
//    _dio.options.contentType= ContentType.parse("application/json") ;

//     if( token.length != 0){
//      _dio.interceptor.request.onSend = (Options options) {
//        options.headers["Authorization"] = token;
//        return options;
//      };
//    }
    //  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //      (client) {
    //    client.findProxy = (uri) {
    //      //proxy to my PC(charles)
    //      return "PROXY 10.1.10.250:8888";
    //    };
    //  };
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
    return _dio;
  }
}
