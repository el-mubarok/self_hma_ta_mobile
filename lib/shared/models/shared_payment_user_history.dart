// To parse this JSON data, do
//
//     final sharedPaymentUserHistory = sharedPaymentUserHistoryFromJson(jsonString);

import 'dart:convert';

SharedPaymentUserHistory sharedPaymentUserHistoryFromJson(String str) =>
    SharedPaymentUserHistory.fromJson(json.decode(str));

String sharedPaymentUserHistoryToJson(SharedPaymentUserHistory data) =>
    json.encode(data.toJson());

class SharedPaymentUserHistory {
  final int code;
  final List<Datum> data;

  SharedPaymentUserHistory({
    required this.code,
    required this.data,
  });

  factory SharedPaymentUserHistory.fromJson(Map<String, dynamic> json) =>
      SharedPaymentUserHistory(
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String uuid;
  final String billingSessionId;
  final String userId;
  final String paymentMethodId;
  final String methodName;
  final String methodType;
  final String methodCode;
  final dynamic bankFee;
  final String ppnPercentage;
  final dynamic ppnTotal;
  final String billAmount;
  final String grandTotal;
  final String paymentId;
  final dynamic paymentStatusVa;
  final dynamic statusVa;
  final dynamic merchantCode;
  final dynamic vaNumber;
  final dynamic paymentStatusEwallet;
  final dynamic statusEwallet;
  final DateTime? expiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic name;

  Datum({
    required this.id,
    required this.uuid,
    required this.billingSessionId,
    required this.userId,
    required this.paymentMethodId,
    required this.methodName,
    required this.methodType,
    required this.methodCode,
    this.bankFee,
    required this.ppnPercentage,
    required this.ppnTotal,
    required this.billAmount,
    required this.grandTotal,
    required this.paymentId,
    this.paymentStatusVa,
    this.statusVa,
    this.merchantCode,
    this.vaNumber,
    this.paymentStatusEwallet,
    this.statusEwallet,
    this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        uuid: json["uuid"],
        billingSessionId: json["billing_session_id"],
        userId: json["user_id"],
        paymentMethodId: json["payment_method_id"],
        methodName: json["method_name"],
        methodType: json["method_type"],
        methodCode: json["method_code"],
        bankFee: json["bank_fee"],
        ppnPercentage: json["ppn_percentage"],
        ppnTotal: json["ppn_total"],
        billAmount: json["bill_amount"],
        grandTotal: json["grand_total"],
        paymentId: json["payment_id"],
        paymentStatusVa: json["payment_status_va"],
        statusVa: json["status_va"],
        merchantCode: json["merchant_code"],
        vaNumber: json["va_number"],
        paymentStatusEwallet: json["payment_status_ewallet"],
        statusEwallet: json["status_ewallet"],
        expiryDate: json["expiry_date"] != null
            ? DateTime.parse(json["expiry_date"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "billing_session_id": billingSessionId,
        "user_id": userId,
        "payment_method_id": paymentMethodId,
        "method_name": methodName,
        "method_type": methodType,
        "method_code": methodCode,
        "bank_fee": bankFee,
        "ppn_percentage": ppnPercentage,
        "ppn_total": ppnTotal,
        "bill_amount": billAmount,
        "grand_total": grandTotal,
        "payment_id": paymentId,
        "payment_status_va": paymentStatusVa,
        "status_va": statusVa,
        "merchant_code": merchantCode,
        "va_number": vaNumber,
        "payment_status_ewallet": paymentStatusEwallet,
        "status_ewallet": statusEwallet,
        "expiry_date":
            expiryDate != null ? expiryDate!.toIso8601String() : null,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
      };
}
