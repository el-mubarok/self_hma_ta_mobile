// To parse this JSON data, do
//
//     final sharedUserListData = sharedUserListDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedUserListData sharedUserListDataFromJson(String str) =>
    SharedUserListData.fromJson(json.decode(str));

String sharedUserListDataToJson(SharedUserListData data) =>
    json.encode(data.toJson());

class SharedUserListData {
  final int code;
  final List<Datum> data;

  SharedUserListData({
    required this.code,
    required this.data,
  });

  factory SharedUserListData.fromJson(Map<String, dynamic> json) =>
      SharedUserListData(
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
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? avatar;
  final dynamic qrCode;
  final String houseNumber;
  final String houseBlock;
  final dynamic defaultPassword;
  final String accountBri;
  final dynamic accountBriEnabled;
  final String accountMandiri;
  final dynamic accountMandiriEnabled;
  final String accountBni;
  final dynamic accountBniEnabled;
  final String accountPermata;
  final dynamic accountPermataEnabled;
  final String accountBca;
  final dynamic accountBcaEnabled;
  final String accountBsi;
  final dynamic accountBsiEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Datum({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.avatar,
    required this.qrCode,
    required this.houseNumber,
    required this.houseBlock,
    required this.defaultPassword,
    required this.accountBri,
    required this.accountBriEnabled,
    required this.accountMandiri,
    required this.accountMandiriEnabled,
    required this.accountBni,
    required this.accountBniEnabled,
    required this.accountPermata,
    required this.accountPermataEnabled,
    required this.accountBca,
    required this.accountBcaEnabled,
    required this.accountBsi,
    required this.accountBsiEnabled,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        avatar: json["avatar"],
        qrCode: json["qr_code"],
        houseNumber: json["house_number"],
        houseBlock: json["house_block"],
        defaultPassword: json["default_password"],
        accountBri: json["account_bri"],
        accountBriEnabled: json["account_bri_enabled"],
        accountMandiri: json["account_mandiri"],
        accountMandiriEnabled: json["account_mandiri_enabled"],
        accountBni: json["account_bni"],
        accountBniEnabled: json["account_bni_enabled"],
        accountPermata: json["account_permata"],
        accountPermataEnabled: json["account_permata_enabled"],
        accountBca: json["account_bca"],
        accountBcaEnabled: json["account_bca_enabled"],
        accountBsi: json["account_bsi"],
        accountBsiEnabled: json["account_bsi_enabled"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "avatar": avatar,
        "qr_code": qrCode,
        "house_number": houseNumber,
        "house_block": houseBlock,
        "default_password": defaultPassword,
        "account_bri": accountBri,
        "account_bri_enabled": accountBriEnabled,
        "account_mandiri": accountMandiri,
        "account_mandiri_enabled": accountMandiriEnabled,
        "account_bni": accountBni,
        "account_bni_enabled": accountBniEnabled,
        "account_permata": accountPermata,
        "account_permata_enabled": accountPermataEnabled,
        "account_bca": accountBca,
        "account_bca_enabled": accountBcaEnabled,
        "account_bsi": accountBsi,
        "account_bsi_enabled": accountBsiEnabled,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at":
            deletedAt != null ? deletedAt?.toIso8601String() : deletedAt,
      };
}
