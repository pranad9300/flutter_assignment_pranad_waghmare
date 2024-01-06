import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../utils/failures.dart';
import '../models/transproter.dart';

class TransporterRemoteDataSource {
  Future<List<Transporter>> getTransporters(String place) async {
    final response = await http.get(
      Uri.parse(
          'https://lorriservice.azurefd.net/api/autocomplete?suggest=$place&amp;limit=20&amp;searchFields=new_locations'),
    );

    try {
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final dynamic data = json.decode(response.body);
        final List<dynamic> transportersJson = data['value'];
        return transportersJson.map((json) => Transporter.fromMap(json)).cast<Transporter>().toList();
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load transporters');
      }
    } on SocketException catch (_) {
      throw InternetFailure();
    } catch (_) {
      throw DefaultFailure();
    }
  }
}
