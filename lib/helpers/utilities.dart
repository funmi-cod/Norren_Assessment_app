import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/helpers/http_exception.dart';

class Utilities {
  static String nairaSign = "₦";
  static String dollarSign = "\$";
  static String formatAmount({required double amount}) {
    final oCcy = NumberFormat("#,##0", "en_US");
    String formattedAmount = oCcy.format(amount);
    return formattedAmount;
  }

  static String productAmount(
      {required String currency, required double amount}) {
    switch (currency) {
      case "naira":
        return "$nairaSign${formatAmount(amount: amount)} ";
      default:
        return "$dollarSign${formatAmount(amount: amount)} ";
    }
  }

  static String productDate(DateTime date) {
    return "${DateFormat.MMMM().format(date)} ${DateFormat.d().format(date)} , ${DateFormat.y().format(date)} at ${DateFormat.jm().format(date)}";
  }

  static String _handleError(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request was cancelled, please try again";
        break;

      case DioErrorType.connectTimeout:
        errorDescription =
            "Connection timeout due to internet connection, please try again";
        break;

      case DioErrorType.sendTimeout:
        errorDescription =
            "Connection timeout due to internet connection, please try again";
        break;

      case DioErrorType.other:
        errorDescription =
            "Connection failed. Check your internet connection and try again";
        break;

      case DioErrorType.receiveTimeout:
        errorDescription =
            "Receive timeout due to internet connection, please try again";
        break;
      default:
        errorDescription = "";
    }
    return errorDescription;
  }

  static void handleDioError(DioError error) {
    String errorMessage = _handleError(error);
    if (errorMessage.isNotEmpty) throw HttpException(errorMessage);
    if (error.response != null) {
      var data = error.response?.data;
      debugPrint("The error ${error.response?.data}");

      if (data["status"] == "error") {
        throw HttpExceptions((data["message"] as String), data: data["data"]);
      }
    } else {
      throw HttpException(error.message);
    }
  }

  static String dioErrorHandler(DioError e) {
    final dioError = e;
    debugPrint(
      "----: ${dioError.type}",
    );

    switch (dioError.type) {
      case DioErrorType.cancel:
        return 'Request was cancelled';
      case DioErrorType.response:
        debugPrint(dioError.response!.statusCode.toString());

        if (dioError.response!.statusCode == 502 ||
            dioError.response!.statusCode == 500 ||
            dioError.response!.statusCode == 504) {
          return dioError.response!.data["message"] ??
              TextLiterals.serverErrorMsg;
        }

        debugPrint("vvbbvb1: => : ${dioError.response!.data}");
        return TextLiterals.serverErrorMsg;

      case DioErrorType.connectTimeout:
        return 'Connection timed out';
      case DioErrorType.other:
        return TextLiterals.errorMsg;
      case DioErrorType.sendTimeout:
        return TextLiterals.errorMsg;
      case DioErrorType.receiveTimeout:
        return "Connection timeout, please try again";
      default:
        return TextLiterals.errorMsg;
    }
  }
}
