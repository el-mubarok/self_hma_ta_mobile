// To parse this JSON data, do
//
//     final sharedAccessListData = sharedAccessListDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedAccessListData sharedAccessListDataFromJson(String str) =>
    SharedAccessListData.fromJson(json.decode(str));

String sharedAccessListDataToJson(SharedAccessListData data) =>
    json.encode(data.toJson());

class SharedAccessListData {
  SharedAccessListData({
    required this.code,
    required this.status,
    required this.data,
  });

  final int code;
  final String status;
  final List<Datum> data;

  factory SharedAccessListData.fromJson(Map<String, dynamic> json) =>
      SharedAccessListData(
        code: json["code"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.deviceId,
    required this.username,
    required this.token,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final String fullName;
  final dynamic deviceId;
  final String username;
  final dynamic token;
  final String status;
  final dynamic deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        deviceId: json["device_id"],
        username: json["username"],
        token: json["token"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "full_name": fullName,
        "device_id": deviceId,
        "username": username,
        "token": token,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
