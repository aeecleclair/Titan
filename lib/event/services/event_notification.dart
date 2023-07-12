import 'package:myecl/event/class/event.dart';
import 'package:myecl/service/local_notification_service.dart';

class EventNotification extends LocalNotificationService {
  void scheduleAllSession(List<Event> eventList) async {
    await pendingNotificationRequests();
    for (Event s in eventList) {
      if (DateTime.now().isBefore(s.start)) {
        showScheduledNotification(
            s.id,
            "Évènement - ${s.name}",
            "La fin est prévue à ${s.end.hour}h${s.end.minute}",
            s.start);
      }
    }
  }
}
