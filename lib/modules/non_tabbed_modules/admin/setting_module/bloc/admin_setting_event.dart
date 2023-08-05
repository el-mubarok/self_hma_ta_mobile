part of 'admin_setting_bloc.dart';

abstract class AdminSettingEvent extends Equatable {
  const AdminSettingEvent();

  @override
  List<Object?> get props => [];
}

class AdminSettingSessionList extends AdminSettingEvent {
  final bool detail;

  const AdminSettingSessionList([this.detail = false]);

  @override
  List<Object> get props => [detail];
}

class AdminSettingSession extends AdminSettingEvent {
  final dynamic id;
  final bool detail;

  const AdminSettingSession(this.id, [this.detail = false]);

  @override
  List<Object> get props => [id, detail];
}

class AdminSettingUpdateSession extends AdminSettingEvent {
  final SharedBillingData? data;
  final String from;
  final String to;
  final String namee;
  final String month;
  final String year;
  final String price;

  const AdminSettingUpdateSession({
    required this.data,
    required this.from,
    required this.to,
    required this.namee,
    required this.month,
    required this.year,
    required this.price,
  });

  @override
  List<Object?> get props => [
        data,
        from,
        to,
        namee,
        month,
        year,
        price,
      ];
}

class ASCreateSessionTime extends AdminSettingEvent {
  final dynamic sessionId;

  const ASCreateSessionTime(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}

class ASUpdateSessionTime extends AdminSettingEvent {
  // final dynamic timeId;
  // final String time;
  final Map<String, dynamic> data;

  const ASUpdateSessionTime(this.data);

  @override
  List<Object> get props => [data];
}

class ASDeleteSessionTime extends AdminSettingEvent {
  final dynamic timeId;

  const ASDeleteSessionTime(this.timeId);

  @override
  List<Object> get props => [timeId];
}

class ASCreateSession extends AdminSettingEvent {
  final SubmitParams params;

  const ASCreateSession(this.params);

  @override
  List<Object> get props => [params];
}
