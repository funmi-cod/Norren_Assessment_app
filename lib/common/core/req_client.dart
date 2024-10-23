import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReqClient {
  Dio dio = Dio();

  Future<Response> postWithoutHeaderClient(url, data) async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    debugPrint(url);
    return await dio.post(url, data: data, options: Options());
  }

  Future<Response> getWithoutHeaderClient(url) async {
    return await dio.get(url, options: Options());
  }
}
