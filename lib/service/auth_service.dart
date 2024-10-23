import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/core/api_constant.dart';
import 'package:norrenberger_app/common/core/req_client.dart';
import 'package:norrenberger_app/env/environment.dart';
import 'package:norrenberger_app/helpers/utilities.dart';

class AuthService {
  var dio = Dio();
  ReqClient requestClient = ReqClient();

  dynamic postLoginData(
      {required String firstName, required String email}) async {
    Map<String, dynamic> body = {
      "email": email,
      "name": firstName,
    };
    try {
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.LOGIN}', body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("RES::::${response.data}");

        return {'status': true, 'message': 'successful', 'data': response.data};
      } else {
        return {
          'status': false,
          'message': response.data["message"] ?? "Error loggin in",
          'data': null
        };
      }
    } on DioError catch (e) {
      final err = Utilities.dioErrorHandler(e);
      return {'status': false, 'message': err, 'data': null};
    }
  }

  dynamic confirmOtp({required String otp, required String email}) async {
    Map<String, dynamic> body = {"otp": otp, "email": email};
    try {
      Response response = await requestClient.postWithoutHeaderClient(
          '${Environment().config.BASE_URL}/${APIConstants.VERIFY_OTP}', body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Login response::: ${response.data["data"]}");

        return {'status': true, 'message': 'successful', 'data': response.data};
      } else {
        return {
          'status': false,
          'message': response.data["message"] ?? "Error Verifying",
          'data': null
        };
      }
    } on DioError catch (e) {
      final err = Utilities.dioErrorHandler(e);
      return {'status': false, 'message': err, 'data': null};
    }
  }
}
