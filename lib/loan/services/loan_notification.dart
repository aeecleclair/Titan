import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/service/local_notification_service.dart';

class LoanNotification extends LocalNotificationService {
  void scheduleAllEndedLoanByLoaner(List<Loan> eventList) async {
    await pendingNotificationRequests();
    for (Loan s in eventList) {
      if (!s.returned && DateTime.now().isAfter(s.end)) {
        showNotification(
          s.id,
          "Prêt - ${s.loaner.name}",
          "Le prêt de ${formatItems(s.items)} arrive à sa fin. Pensez à le rendre.",
        );
      }
    }
  }

  void scheduleAllEndedLoanByUser(List<Loan> eventList) async {
    await pendingNotificationRequests();
    for (Loan s in eventList) {
      if (!s.returned && DateTime.now().isAfter(s.end)) {
        showNotification(
          s.id,
          "Prêt - ${s.borrower.getName()}",
          "Le prêt de ${formatItems(s.items)} arrive à sa fin. Pensez à relancer.",
        );
      }
    }
  }
}
