// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:housing_management_mobile/modules/non_tabbed_modules/admin/setting_module/data/admin_setting_repository.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_data.dart';
import 'package:housing_management_mobile/shared/models/shared_billing_list_data.dart';
import 'package:housing_management_mobile/shared/models/shared_user_data_model.dart';
import 'package:housing_management_mobile/shared/utils/utils.dart';
import 'package:housing_management_mobile/shared/utils/utils_global.dart';

part 'admin_setting_event.dart';
part 'admin_setting_state.dart';

class AdminSettingBloc extends Bloc<AdminSettingEvent, AdminSettingState> {
  AdminSettingRepository repository;

  AdminSettingBloc({
    required this.repository,
  }) : super(AdminSettingInitial()) {
    on<AdminSettingSessionList>(_adminSettingSessionList);
    on<AdminSettingSession>(_adminSettingSession);
    on<AdminSettingUpdateSession>(_adminSettingUpdateSession);
    //
    on<ASCreateSessionTime>(_aSCreateSessionTime);
    on<ASUpdateSessionTime>(_aSUpdateSessionTime);
    on<ASDeleteSessionTime>(_aSDeleteSessionTime);
    on<ASCreateSession>(_aSCreateSession);
  }

  void _aSCreateSession(
    ASCreateSession event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASCreateSessionLoading());

    SubmitParams params = SubmitParams(
      adminId: event.params.adminId,
      name: event.params.name,
      description: event.params.description,
      fromDate: event.params.fromDate,
      toDate: event.params.toDate,
      price: event.params.price,
    );
    bool result = await repository.submitCreateSession(params);

    if (result) {
      emit(ASCreateSessionSuccess());
    } else {
      emit(ASCreateSessionFailed());
    }
  }

  void _adminSettingSessionList(
    AdminSettingSessionList event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASListLoadingState());
    // load user list
    SharedBillingListData? data = await repository.getListBilling();

    emit(ASListState(data));
  }

  void _adminSettingSession(
    AdminSettingSession event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASListLoadingState());
    // load user list
    SharedBillingData? data = await repository.getBilling(
      event.id,
      event.detail,
    );

    emit(ASBillingState(data));
  }

  void _adminSettingUpdateSession(
    AdminSettingUpdateSession event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASUpdateLoadingState());

    // var dFrom = event.data?.data.fromDate.toIso8601String();
    // var dTo = event.data?.data.toDate.toIso8601String();

    // var dFromArr = dFrom?.split('-');
    // var dToArr = dTo?.split('-');

    // dFromArr?[dFromArr.length - 1] = event.from;
    // dToArr?[dToArr.length - 1] = event.to;

    // dFrom = dFromArr?.join('-');
    // dTo = dToArr?.join('-');

    var dFrom = '${event.year}-${event.month}-${event.from}';
    var dTo = '${event.year}-${event.month}-${event.to}';

    AppUtils.logD('$dFrom - $dTo');

    SubmitParams params = SubmitParams(
      adminId: event.data?.data.adminId ?? '',
      name: event.namee,
      description: event.data?.data.description ?? '',
      fromDate: dFrom,
      toDate: dTo,
      price: event.price,
    );
    var id = event.data?.data.id;

    AppUtils.logD('PPPPPP: ${params.name}');
    AppUtils.logD('PPPPPP: ${params.toDate}');
    AppUtils.logD('PPPPPP: ${params.fromDate}');
    AppUtils.logD('PPPPPP: ${params.price}');

    // emit(ASUpdateFailed());

    // return;

    var result = await repository.submitCreateSession(params, true, id);

    if (result) {
      emit(ASUpdateSuccess());
    } else {
      emit(ASUpdateFailed());
    }
  }

  void _aSCreateSessionTime(
    ASCreateSessionTime event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASListLoadingState());
    // load user list
    List<SubmitTimeParams> paramss = [];
    SharedUserData? user = AppUtilsGlobal().userData.value;

    SubmitTimeParams params = SubmitTimeParams(
      adminId: user?.data.id ?? '',
      billingSessionId: event.sessionId,
      timeStamp: '08:00',
    );
    paramss.add(params);

    bool result = await repository.submitCreateSessionTime(paramss);

    if (result) {
      emit(ASSessionTimeCreateSuccess());
    } else {
      emit(ASSessionTimeCreateFailed());
    }
  }

  void _aSUpdateSessionTime(
    ASUpdateSessionTime event,
    Emitter<AdminSettingState> emit,
  ) async {
    emit(ASUpdateLoadingState());
    // load user list
    List<SubmitTimeParams> paramss = [];

    event.data.forEach((key, value) async {
      SubmitTimeParams params = SubmitTimeParams(
        adminId: '',
        billingSessionId: '',
        timeStamp: value,
        timeId: key,
      );
      paramss.add(params);
    });

    bool result = await repository.submitCreateSessionTime(
      paramss,
      true,
      0,
    );

    if (result) {
      emit(ASSessionTimeUpdateSuccess());
    } else {
      emit(ASSessionTimeUpdateFailed());
    }
  }

  void _aSDeleteSessionTime(
    ASDeleteSessionTime event,
    Emitter<AdminSettingState> emit,
  ) async {
    if (event.timeId != null) {
      emit(ASSessionTimeDeleteLoadingState());

      bool result = await repository.deleteSessionTime(event.timeId);

      if (result) {
        emit(ASSessionTimeDeleteSuccess());
      } else {
        emit(ASSessionTimeDeleteFailed());
      }
    }
  }
}
