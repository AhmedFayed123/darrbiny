import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../constant/app_constant.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));

    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
      data: body,
    );
  }

  static Future<Response> getDataWithoutToken({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    String? lang,
    String? token,
    bool isMultipart = false,
  }) async {
    final headers = {
      'lang': AppConstant.currentLanguage,
      'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    dio!.options.headers = headers;

    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        validateStatus: (status) => status != null,
      ),
    );
  }


  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.delete(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postDataWithoutToken({
    required String url,
    Map<String, dynamic>? query,
    required Object data,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Authorization': token == null ? '' : 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang,
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': AppConstant.currentLanguage,
      'Authorization': token!,
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
