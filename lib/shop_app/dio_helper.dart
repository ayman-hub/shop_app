import 'package:dio/dio.dart';
import 'package:dio_helper_flutter/dio_helper.dart' as d;

class DioHelper {
  static getData({String? url, String? token, required Function(dynamic) success, required Function(dynamic) catchError}) {
    d.DioHelper apiRepository = d.DioHelper(Dio());
    apiRepository.request(url??"",queryParameter: {
      'token':token
    }, success: (response) {
      success(response);
    }, error: (error) {
      print(
          'Error ${error.errorLanguageEntity!.defaultLanguage} ${error.statusCode}');
      catchError(error);
    },dioMethod: d.DioMethod.get);
  }

  static postData({String? url, Map<String, String>? data , required Function(dynamic) success, required Function(dynamic) catchError}) {
    d.DioHelper apiRepository = d.DioHelper(Dio());
    var responses;
  //  FormData formData = FormData.fromMap(data!);
    apiRepository.request(url??"",data: data, success: (response) {
      responses = response;
      success(response);
    }, error: (error) {
      catchError(error);
    },dioMethod: d.DioMethod.post);

  }
}
