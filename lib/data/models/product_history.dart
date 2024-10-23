// To parse this JSON data, do
//
//     final productHistory = productHistoryFromJson(jsonString);

import 'dart:convert';

ProductHistory productHistoryFromJson(String str) =>
    ProductHistory.fromJson(json.decode(str));

String productHistoryToJson(ProductHistory data) => json.encode(data.toJson());

class ProductHistory {
  List<Result>? result;

  ProductHistory({
    this.result,
  });

  factory ProductHistory.fromJson(Map<String, dynamic> json) => ProductHistory(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  String? productId;
  String? productName;
  String? currency;
  String? description;
  int? minWithrawal;
  int? minFund;
  String? features;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SubProduct>? subProduct;

  Result({
    this.id,
    this.productId,
    this.productName,
    this.currency,
    this.description,
    this.minWithrawal,
    this.minFund,
    this.features,
    this.createdAt,
    this.updatedAt,
    this.subProduct,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        currency: json["currency"],
        description: json["description"],
        minWithrawal: json["minWithrawal"],
        minFund: json["minFund"],
        features: json["features"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        subProduct: json["sub_product"] == null
            ? []
            : List<SubProduct>.from(
                json["sub_product"]!.map((x) => SubProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "currency": currency,
        "description": description,
        "minWithrawal": minWithrawal,
        "minFund": minFund,
        "features": features,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sub_product": subProduct == null
            ? []
            : List<dynamic>.from(subProduct!.map((x) => x.toJson())),
      };
}

class SubProduct {
  int? id;
  String? productId;
  String? title;
  String? description;
  String? currency;
  String? minWithrawal;
  String? minFund;
  String? features;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubProduct({
    this.id,
    this.productId,
    this.title,
    this.description,
    this.currency,
    this.minWithrawal,
    this.minFund,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  factory SubProduct.fromJson(Map<String, dynamic> json) => SubProduct(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        currency: json["currency"],
        minWithrawal: json["minWithrawal"],
        minFund: json["minFund"],
        features: json["features"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "title": title,
        "description": description,
        "currency": currency,
        "minWithrawal": minWithrawal,
        "minFund": minFund,
        "features": features,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
