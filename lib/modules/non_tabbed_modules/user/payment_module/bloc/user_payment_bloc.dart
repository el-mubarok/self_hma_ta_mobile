// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/user/dashboard_module/data/user_dashboard_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_payment_active.dart';
import 'package:housing_management_mobile/shared/models/shared_payment_request_result.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';

import '../../../../../shared/models/shared_payment_calculate.dart';
import '../data/user_payment_repository.dart';

part 'user_payment_event.dart';
part 'user_payment_state.dart';

class UserPaymentBloc extends Bloc<UserPaymentEvent, UserPaymentState> {
  final UserPaymentRepository repository;
  final UserDashboardRepository dashboardRepository;

  UserPaymentBloc({
    required this.repository,
    required this.dashboardRepository,
  }) : super(UserPaymentInitial()) {
    on<UserPaymentCalculate>(_userPaymentCalculate);
    on<UserPaymentRequestEvent>(_userPaymentRequestEvent);
    on<UserPaymentCrossCheckEvent>(_userPaymentCrossCheckEvent);
  }

  void _userPaymentCrossCheckEvent(
    UserPaymentCrossCheckEvent event,
    Emitter<UserPaymentState> emit,
  ) async {
    emit(UPCrossCheckedLoading());

    await Future.delayed(const Duration(seconds: 2));

    emit(UPCrossChecked());
  }

  void _userPaymentCalculate(
    UserPaymentCalculate event,
    Emitter<UserPaymentState> emit,
  ) async {
    emit(UPCalculateLoading());

    SharedPaymentCalculate? data = await repository.calculatePayment(
      event.code,
      event.price,
    );

    emit(UPCalculateData(data));
  }

  void _userPaymentRequestEvent(
    UserPaymentRequestEvent event,
    Emitter<UserPaymentState> emit,
  ) async {
    emit(UPRequestLoading());

    RequestParams params = RequestParams(
      billingSessionId: event.billingSessionId,
      paymentMethodId: event.paymentMethodId,
      baseAmount: event.baseAmount,
      amount: event.amount,
    );

    SharedPaymentRequestResult? data = await repository.requestPayment(
      params,
    );

    SharedBillingPaymentActive? details = await repository.getPaymentDetails(
      data?.data.paymentId,
    );

    AppUtils.logD("details data: ${details.toString()}");

    if (details != null) {
      if (data?.data.type == 'va') {
        emit(UPRequestVaSuccess(details));
      } else if (data?.data.type == 'ewallet') {
        emit(UPRequestEwalletSuccess(data));
      }
    } else {
      emit(UPRequestFailed());
    }

    // emit(UPRequestData(data));
  }
}
