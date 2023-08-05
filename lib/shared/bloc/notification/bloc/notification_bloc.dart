// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({
    required this.repository,
  }) : super(NotificationInitial()) {
    on<NotificationEventInitialize>(_initialize);
  }

  void _initialize(
    NotificationEventInitialize event,
    Emitter<NotificationState> emit,
  ) async {
    repository.initializeNotification();
  }
}
