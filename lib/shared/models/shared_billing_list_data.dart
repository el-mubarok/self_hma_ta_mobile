// To parse this JSON data, do
//
//     final sharedBillingListData = sharedBillingListDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SharedBillingListData sharedBillingListDataFromJson(String str) =>
    SharedBillingListData.fromJson(json.decode(str));

String sharedBillingListDataToJson(SharedBillingListData data) =>
    json.encode(data.toJson());

class SharedBillingListData {
  final int code;
  final List<Datum> data;

  SharedBillingListData({
    required this.code,
    required this.data,
  });

  factory SharedBillingListData.fromJson(Map<String, dynamic> json) =>
      SharedBillingListData(
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
  final String adminId;
  final String name;
  final String description;
  final dynamic status;
  final DateTime fromDate;
  final DateTime toDate;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Reminder> reminder;
  final List<Payment>? payments;
  final dynamic paymentProgress;
  final dynamic totalUser;
  final dynamic completeUser;

  Datum({
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
    required this.reminder,
    this.payments,
    this.paymentProgress,
    this.totalUser,
    this.completeUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        reminder: List<Reminder>.from(
            json["reminder"].map((x) => Reminder.fromJson(x))),
        payments: json["payments"] != null
            ? List<Payment>.from(
                json["payments"].map((x) => Payment.fromJson(x)))
            : null,
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
        "reminder": List<dynamic>.from(reminder.map((x) => x.toJson())),
        "payments": payments != null
            ? List<dynamic>.from(payments!.map((x) => x.toJson()))
            : null,
        "payment_progress": paymentProgress,
        "total_user": totalUser,
        "complete_user": completeUser,
      };
}

class Payment {
  final String id;
  final String uuid;
  final String billingSessionId;
  final String userId;
  final String paymentMethodId;
  final String methodName;
  final String methodType;
  final String methodCode;
  final String bankFee;
  final String ppnPercentage;
  final String ppnTotal;
  final String billAmount;
  final String grandTotal;
  final String paymentId;
  final dynamic paymentStatusVa;
  final String statusVa;
  final String merchantCode;
  final String vaNumber;
  final dynamic paymentStatusEwallet;
  final String statusEwallet;
  final dynamic expiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final PaymentMethod paymentMethod;

  Payment({
    required this.id,
    required this.uuid,
    required this.billingSessionId,
    required this.userId,
    required this.paymentMethodId,
    required this.methodName,
    required this.methodType,
    required this.methodCode,
    required this.bankFee,
    required this.ppnPercentage,
    required this.ppnTotal,
    required this.billAmount,
    required this.grandTotal,
    required this.paymentId,
    required this.paymentStatusVa,
    required this.statusVa,
    required this.merchantCode,
    required this.vaNumber,
    required this.paymentStatusEwallet,
    required this.statusEwallet,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.paymentMethod,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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
        expiryDate: json["expiry_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
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
        "expiry_date": expiryDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "payment_method": paymentMethod.toJson(),
      };
}

class PaymentMethod {
  final String id;
  final String name;
  final String type;
  final String code;
  final String ppn;
  final String ppnPercentage;
  final dynamic merchantCode;
  final String isActive;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.code,
    required this.ppn,
    required this.ppnPercentage,
    required this.merchantCode,
    required this.isActive,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        code: json["code"],
        ppn: json["ppn"],
        ppnPercentage: json["ppn_percentage"],
        merchantCode: json["merchant_code"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "code": code,
        "ppn": ppn,
        "ppn_percentage": ppnPercentage,
        "merchant_code": merchantCode,
        "is_active": isActive,
      };
}

class User {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String avatar;
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
  final dynamic playId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.avatar,
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
    required this.playId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        playId: json["play_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
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
        "play_id": playId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class Reminder {
  final String id;
  final String billingSessionId;
  final String adminId;
  final String timeStamp;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reminder({
    required this.id,
    required this.billingSessionId,
    required this.adminId,
    required this.timeStamp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        id: json["id"],
        billingSessionId: json["billing_session_id"],
        adminId: json["admin_id"],
        timeStamp: json["time_stamp"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "billing_session_id": billingSessionId,
        "admin_id": adminId,
        "time_stamp": timeStamp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
