import 'dart:convert';

SharedBillingPaymentActive sharedBillingPaymentActiveFromJson(String str) =>
    SharedBillingPaymentActive.fromJson(json.decode(str));

String sharedBillingPaymentActiveToJson(SharedBillingPaymentActive data) =>
    json.encode(data.toJson());

class SharedBillingPaymentActive {
  final int code;
  final Data data;

  SharedBillingPaymentActive({
    required this.code,
    required this.data,
  });

  factory SharedBillingPaymentActive.fromJson(Map<String, dynamic> json) =>
      SharedBillingPaymentActive(
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
  final PaymentActions? paymentActions;

  Data({
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
    this.paymentActions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        paymentActions: json["payment_actions"] != null
            ? PaymentActions.fromJson(json["payment_actions"])
            : null,
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
        "payment_actions":
            paymentActions != null ? paymentActions!.toJson() : null,
      };
}

class PaymentActions {
  final dynamic desktopWebCheckoutUrl;
  final dynamic mobileWebCheckoutUrl;
  final dynamic mobileDeeplinkCheckoutUrl;
  final dynamic qrCheckoutString;

  PaymentActions({
    this.desktopWebCheckoutUrl,
    this.mobileWebCheckoutUrl,
    this.mobileDeeplinkCheckoutUrl,
    this.qrCheckoutString,
  });

  factory PaymentActions.fromJson(Map<String, dynamic> json) => PaymentActions(
        desktopWebCheckoutUrl: json["desktop_web_checkout_url"],
        mobileWebCheckoutUrl: json["mobile_web_checkout_url"],
        mobileDeeplinkCheckoutUrl: json["mobile_deeplink_checkout_url"],
        qrCheckoutString: json["qr_checkout_string"],
      );

  Map<String, dynamic> toJson() => {
        "desktop_web_checkout_url": desktopWebCheckoutUrl,
        "mobile_web_checkout_url": mobileWebCheckoutUrl,
        "mobile_deeplink_checkout_url": mobileDeeplinkCheckoutUrl,
        "qr_checkout_string": qrCheckoutString,
      };
}
