import 'dart:convert';

import 'package:myecl/booking/class/booking.dart';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository.dart';

class BookingRepository extends Repository {
  final ext = 'bdebooking/bookings';

  Future<List<Booking>> getBookingList() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Booking>.from(
            json.decode(resp).map((x) => Booking.fromJson(x)));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load bookings");
    }
  }

  Future<Booking> createBooking(Booking booking) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(booking));
    if (response.statusCode == 201) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return Booking.fromJson(json.decode(resp));
      } catch (e) {
        throw AppException(ErrorType.invalidData, "Failed to create booking");
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to create booking");
    }
  }

  Future<bool> updateBooking(Booking booking) async {
    final response = await http.patch(Uri.parse(host + ext + booking.id),
        headers: headers, body: json.encode(booking));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update booking");
    }
  }

  Future<bool> deleteBooking(Booking booking) async {
    final response =
        await http.delete(Uri.parse(host + ext + booking.id), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to delete booking");
    }
  }

  Future<List<Booking>> getHistoryBookingList() async {
    final response = await http.get(Uri.parse(host + ext + '/unconfirmed'),
        headers: headers);
    if (response.statusCode == 200) {
      try {
        String resp = utf8.decode(response.body.runes.toList());
        return List<Booking>.from(
            json.decode(resp).map((x) => Booking.fromJson(x)));
      } catch (e) {
        return [];
      }
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to load bookings");
    }
  }
}
