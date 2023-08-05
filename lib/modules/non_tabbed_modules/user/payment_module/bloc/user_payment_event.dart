part of 'user_payment_bloc.dart';

abstract class UserPaymentEvent extends Equatable {
  const UserPaymentEvent();

  @override
  List<Object?> get props => [];
}

class UserPaymentCalculate extends UserPaymentEvent {
  final String code;
  final String price;

  const UserPaymentCalculate(this.code, this.price);

  @override
  List<Object> get props => [code, price];
}

class UserPaymentRequestEvent extends UserPaymentEvent {
  final String billingSessionId;
  final String paymentMethodId;
  final String baseAmount;
  final String amount;
  final String? phoneNumber;

  const UserPaymentRequestEvent({
    required this.billingSessionId,
    required this.paymentMethodId,
    required this.baseAmount,
    required this.amount,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        billingSessionId,
        paymentMethodId,
        baseAmount,
        amount,
        phoneNumber,
      ];
}

class UserPaymentCrossCheckEvent extends UserPaymentEvent {}
