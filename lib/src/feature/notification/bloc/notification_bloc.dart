import 'package:e_learning/src/feature/notification/model/notification_model.dart';
import 'package:e_learning/src/feature/notification/res/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(FetchingNotification());
  List<NotificationModel> notificationModel = [];
  NotificationRepository _notificationRepository = NotificationRepository();
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotificationStarted) {
      yield FetchingNotification();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<NotificationModel> _temList = await _notificationRepository
            .getNotification(page: page, rowperpage: rowperpage);
        notificationModel.addAll(_temList);
        page++;
        if (_temList.length < rowperpage) {
          print(notificationModel.length);
          yield EndOfNotificationList();
        } else {
          print(notificationModel.length);
          yield FetchedNotification();
        }
      } catch (e) {
        print(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
    if (event is InitailizeNotificationStarted) {
      yield InitializingNotification();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<NotificationModel> _temList = await _notificationRepository
            .getNotification(page: page, rowperpage: rowperpage);
        notificationModel.addAll(_temList);
        page++;
        yield InitailizedNotification();
      } catch (e) {
        print(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
    if (event is RefreshNotificationStarted) {
      yield FetchingNotification();
      try {
        notificationModel.clear();
        page = 1;
        // Future.delayed(Duration(milliseconds: 200));
        List<NotificationModel> _temList = await _notificationRepository
            .getNotification(page: page, rowperpage: rowperpage);
        notificationModel.addAll(_temList);
        page++;
        yield FetchedNotification();
      } catch (e) {
        print(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
  }
}
