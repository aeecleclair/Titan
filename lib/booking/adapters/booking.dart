import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/user/adapters/applicants.dart';

extension $BookingReturnApplicant on BookingReturnApplicant {
  BookingReturnSimpleApplicant toBookingReturnSimpleApplicant() {
    return BookingReturnSimpleApplicant(
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
      applicant: applicant.toCoreUserSimple(),
    );
  }

  BookingReturn toBookingReturn() {
    return BookingReturn(
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
