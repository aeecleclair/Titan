import 'package:titan/generated/openapi.models.swagger.dart';

extension $BookingReturn on BookingReturn {
  BookingReturnApplicant toBookingReturnApplicant() {
    return BookingReturnApplicant(
      reason: reason,
      start: start,
      end: end,
      creation: creation,
      roomId: roomId,
      key: key,
      id: id,
      decision: decision,
      applicantId: applicantId,
      room: room,
      applicant: Applicant.fromJson({}),
    );
  }

  BookingBase toBookingBase() {
    return BookingBase(
      reason: reason,
      start: start,
      end: end,
      creation: creation,
      roomId: roomId,
      key: key,
    );
  }

  BookingEdit toBookingEdit() {
    return BookingEdit(
      reason: reason,
      start: start,
      end: end,
      note: note,
      roomId: roomId,
      key: key,
      recurrenceRule: recurrenceRule,
      entity: entity,
    );
  }
}
