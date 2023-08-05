// To parse this JSON data, do
//
//     final sharedPaymentCalculate = sharedPaymentCalculateFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedPaymentCalculate sharedPaymentCalculateFromJson(String str) =>
    SharedPaymentCalculate.fromJson(json.decode(str));

String sharedPaymentCalculateToJson(SharedPaymentCalculate data) =>
    json.encode(data.toJson());

class SharedPaymentCalculate {
  final int code;
  final Data data;

  SharedPaymentCalculate({
    required this.code,
    required this.data,
  });

  factory SharedPaymentCalculate.fromJson(Map<String, dynamic> json) =>
      SharedPaymentCalculate(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  final int ppn;
  final int baseAmount;
  final int amount;

  Data({
    required this.ppn,
    required this.baseAmount,
    required this.amount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ppn: json["ppn"],
        baseAmount: json["base_amount"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "ppn": ppn,
        "base_amount": baseAmount,
        "amount": amount,
      };
}
