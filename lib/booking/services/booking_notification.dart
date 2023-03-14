import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/tools/service/local_notification_service.dart';

class BookingNotification extends LocalNotificationService {
  void scheduleAllSession(List<Booking> bookingList) async {
    await pendingNotificationRequests();
    for (Booking s in bookingList) {
      if (s.decision == Decision.approved && DateTime.now().isBefore(s.start)) {
        showScheduledNotification(
            s.id,
            "Réservation - ${s.room}",
            "Vous avez réservé une salle de ${s.start.hour}h${s.start.minute} à ${s.end.hour}h${s.end.minute}",
            s.start.subtract(const Duration(minutes: 10)));
      }
    }
  }
}
