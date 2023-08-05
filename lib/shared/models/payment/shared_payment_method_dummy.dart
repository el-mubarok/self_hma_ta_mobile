// To parse this JSON data, do
//
//     final sharedPaymentMethodDummy = sharedPaymentMethodDummyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SharedPaymentMethodDummy> sharedPaymentMethodDummyFromJson(String str) =>
    List<SharedPaymentMethodDummy>.from(
        json.decode(str).map((x) => SharedPaymentMethodDummy.fromJson(x)));

String sharedPaymentMethodDummyToJson(List<SharedPaymentMethodDummy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SharedPaymentMethodDummy {
  final int id;
  final String label;
  final String? labelAbbr;
  final bool checked;
  final String logo;
  final String? message;
  final bool isActive;
  final dynamic ppn;
  final bool ppnPercentage;

  SharedPaymentMethodDummy({
    required this.id,
    required this.label,
    this.labelAbbr,
    required this.checked,
    required this.logo,
    this.message,
    required this.isActive,
    required this.ppn,
    required this.ppnPercentage,
  });

  factory SharedPaymentMethodDummy.fromJson(Map<String, dynamic> json) =>
      SharedPaymentMethodDummy(
        id: json["id"],
        label: json["label"],
        labelAbbr: json["label_abbr"],
        checked: json["checked"],
        logo: json["logo"],
        message: json["message"],
        isActive: json["is_active"],
        ppn: json["ppn"],
        ppnPercentage: json["ppn_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "label_abbr": labelAbbr,
        "checked": checked,
        "logo": logo,
        "message": message,
        "is_active": isActive,
        "ppn": ppn,
        "ppn_percentage": ppnPercentage,
      };
}
