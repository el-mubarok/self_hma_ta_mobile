// To parse this JSON data, do
//
//     final sharedUserData = sharedUserDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedUserData sharedUserDataFromJson(String str) =>
    SharedUserData.fromJson(json.decode(str));

String sharedUserDataToJson(SharedUserData data) => json.encode(data.toJson());

class SharedUserData {
  final int code;
  final Data data;

  SharedUserData({
    required this.code,
    required this.data,
  });

  factory SharedUserData.fromJson(Map<String, dynamic> json) => SharedUserData(
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
  final String? email;
  final String? fullName;
  final String? username;
  final String? phoneNumber;
  final String? avatar;
  final String? houseNumber;
  final String? houseBlock;
  final dynamic defaultPassword;
  final String? accountBri;
  final String? accountMandiri;
  final String? accountBni;
  final String? accountPermata;
  final String? accountBca;
  final String? accountBsi;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final DateTime? deletedAt;

  Data({
    required this.id,
    this.email,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.avatar,
    this.houseNumber,
    this.houseBlock,
    this.defaultPassword,
    this.accountBri,
    this.accountMandiri,
    this.accountBni,
    this.accountPermata,
    this.accountBca,
    this.accountBsi,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        avatar: json["avatar"],
        houseNumber: json["house_number"],
        houseBlock: json["house_block"],
        defaultPassword: json["default_password"],
        accountBri: json["account_bri"],
        accountMandiri: json["account_mandiri"],
        accountBni: json["account_bni"],
        accountPermata: json["account_permata"],
        accountBca: json["account_bca"],
        accountBsi: json["account_bsi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "avatar": avatar,
        "house_number": houseNumber,
        "house_block": houseBlock,
        "default_password": defaultPassword,
        "account_bri": accountBri,
        "account_mandiri": accountMandiri,
        "account_bni": accountBni,
        "account_permata": accountPermata,
        "account_bca": accountBca,
        "account_bsi": accountBsi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type": type,
        "deleted_at":
            deletedAt != null ? deletedAt?.toIso8601String() : deletedAt,
      };
}
