// To parse this JSON data, do
//
//     final sharedBillingActive = sharedBillingActiveFromJson(jsonString);

import 'dart:convert';

SharedBillingActive sharedBillingActiveFromJson(String str) =>
    SharedBillingActive.fromJson(json.decode(str));

String sharedBillingActiveToJson(SharedBillingActive data) =>
    json.encode(data.toJson());

class SharedBillingActive {
  final int code;
  final Data data;

  SharedBillingActive({
    required this.code,
    required this.data,
  });

  factory SharedBillingActive.fromJson(Map<String, dynamic> json) =>
      SharedBillingActive(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  final String id;
  final String adminId;
  final String name;
  final String description;
  final dynamic status;
  final DateTime fromDate;
  final DateTime toDate;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic isPaid;
  final dynamic paymentProgress;
  final dynamic totalUser;
  final dynamic completeUser;

  Data({
    required this.id,
    required this.adminId,
    required this.name,
    required this.description,
    required this.status,
    required this.fromDate,
    required this.toDate,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.isPaid,
    this.completeUser,
    this.paymentProgress,
    this.totalUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        adminId: json["admin_id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isPaid: json["is_paid"],
        paymentProgress: json["payment_progress"],
        totalUser: json["total_user"],
        completeUser: json["complete_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "name": name,
        "description": description,
        "status": status,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_paid": isPaid,
        "payment_progress": paymentProgress,
        "total_user": totalUser,
        "complete_user": completeUser,
      };
}
