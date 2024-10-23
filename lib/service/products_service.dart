import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/core/api_constant.dart';
import 'package:norrenberger_app/common/core/req_client.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/env/environment.dart';
import 'package:norrenberger_app/helpers/utilities.dart';

class ProductsService {
  var dio = Dio();
  ReqClient requestClient = ReqClient();

  ProductHistory? productHistory;

  Future<ProductHistory?> fetchProductHistory() async {
    Response response;
    try {
      response = await requestClient.getWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.GET_PRODUCTS}/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("product data..${json.encode(response.data)}");
        productHistory = ProductHistory(result: []);
        ProductHistory products = ProductHistory.fromJson(response.data);
        if (products.result != null && products.result!.isNotEmpty) {
          for (var item in products.result!) {
            productHistory!.result!.add(item);
          }
        }

        return productHistory;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioError catch (e) {
      debugPrint("Error product: $e");
      Utilities.handleDioError(e);
    }
  }
}
