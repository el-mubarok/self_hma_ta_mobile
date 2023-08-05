part of 'user_payment_bloc.dart';

abstract class UserPaymentState extends Equatable {
  const UserPaymentState();

  @override
  List<Object?> get props => [];
}

class UserPaymentInitial extends UserPaymentState {}

class UPCalculateLoading extends UserPaymentState {}

class UPCalculateData extends UserPaymentState {
  final SharedPaymentCalculate? data;

  const UPCalculateData(this.data);

  @override
  List<Object?> get props => [data];
}

class UPRequestLoading extends UserPaymentState {}

class UPRequestData extends UserPaymentState {
  final SharedPaymentRequestResult? data;

  const UPRequestData(this.data);

  @override
  List<Object?> get props => [data];
}

class UPRequestVaSuccess extends UserPaymentState {
  final SharedBillingPaymentActive? data;

  const UPRequestVaSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class UPRequestEwalletSuccess extends UserPaymentState {
  final SharedPaymentRequestResult? data;

  const UPRequestEwalletSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class UPRequestFailed extends UserPaymentState {}

class UPCrossCheckedLoading extends UserPaymentState {}

class UPCrossChecked extends UserPaymentState {}
