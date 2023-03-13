import 'package:myecl/cinema/class/session.dart';
import 'package:myecl/tools/service/local_notification_service.dart';

class CinemaNotification extends LocalNotificationService {
  void scheduleAllSession(List<Session> sessionList) async {
    await pendingNotificationRequests();
    for (Session s in sessionList) {
      if (DateTime.now().isBefore(s.start)) {
        showScheduledNotification(
            s.id,
            "Cinéma - ${s.name}",
            "La séance commence dans 10 min !",
            s.start.subtract(const Duration(minutes: 10)));
      }
    }
  }
}
