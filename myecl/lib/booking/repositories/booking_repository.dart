import 'dart:convert';

import 'package:myecl/booking/class/res.dart';
import 'package:http/http.dart' as http;

class BookingRepository {
  final host = 'http://10.0.2.2:8000/';
  final ext = 'bdebooking/bookings';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<Booking>> getBookingList() async {
    final response = await http.get(Uri.parse(host + ext), headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Booking>.from(json.decode(resp));
    } else {
      throw Exception("Failed to load booking list");
    }
  }

  Future<bool> createBooking(Booking booking) async {
    final response = await http.post(Uri.parse(host + ext),
        headers: headers, body: json.encode(booking));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Failed to create booking");
    }
  }

  Future<bool> updateBooking(Booking booking) async {
    final response = await http.patch(Uri.parse(host + ext + booking.id),
        headers: headers, body: json.encode(booking));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update booking");
    }
  }

  Future<bool> deleteBooking(Booking booking) async {
    final response =
        await http.delete(Uri.parse(host + ext + booking.id), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete booking");
    }
  }

  Future<List<Booking>> getHistoryBookingList() async {
    final response = await http.get(Uri.parse(host + ext + '/unconfirmed'),
        headers: headers);
    if (response.statusCode == 200) {
      String resp = utf8.decode(response.body.runes.toList());
      return List<Booking>.from(json.decode(resp));
    } else {
      throw Exception("Failed to load booking list");
    }
  }
}