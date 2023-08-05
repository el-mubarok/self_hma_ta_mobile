// To parse this JSON data, do
//
//     final sharedPaymentRequestResult = sharedPaymentRequestResultFromJson(jsonString);

import 'dart:convert';

SharedPaymentRequestResult sharedPaymentRequestResultFromJson(String str) =>
    SharedPaymentRequestResult.fromJson(json.decode(str));

String sharedPaymentRequestResultToJson(SharedPaymentRequestResult data) =>
    json.encode(data.toJson());

class SharedPaymentRequestResult {
  final int code;
  final Data data;

  SharedPaymentRequestResult({
    required this.code,
    required this.data,
  });

  factory SharedPaymentRequestResult.fromJson(Map<String, dynamic> json) =>
      SharedPaymentRequestResult(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  final String type;
  final String paymentId;
  final String status;
  final DateTime? expiryDate;
  final String? merchantCode;
  final String? vaNumber;
  final dynamic phoneNumber;
  final String? channelCode;
  final Actions? actions;

  Data({
    required this.type,
    required this.paymentId,
    required this.status,
    this.expiryDate,
    this.merchantCode,
    this.vaNumber,
    this.phoneNumber,
    this.channelCode,
    this.actions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        paymentId: json["payment_id"],
        status: json["status"],
        expiryDate: json["expiry_date"] != null
            ? DateTime.parse(json["expiry_date"])
            : null,
        merchantCode: json["merchant_code"],
        vaNumber: json["va_number"],
        phoneNumber: json["phone_number"],
        channelCode: json["channel_code"],
        actions:
            json["actions"] != null ? Actions.fromJson(json["actions"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "payment_id": paymentId,
        "status": status,
        "expiry_date":
            expiryDate != null ? expiryDate!.toIso8601String() : null,
        "merchant_code": merchantCode,
        "va_number": vaNumber,
        "phone_number": phoneNumber,
        "channel_code": channelCode,
        "actions": actions != null ? actions!.toJson() : null,
      };
}

class Actions {
  final String checkoutUrl;

  Actions({
    required this.checkoutUrl,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
        checkoutUrl: json["checkout_url"],
      );

  Map<String, dynamic> toJson() => {
        "checkout_url": checkoutUrl,
      };
}
