import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class RefreshNotificationStarted extends NotificationEvent {}

class FetchNotificationStarted extends NotificationEvent {}

class InitailizeNotificationStarted extends NotificationEvent {}
