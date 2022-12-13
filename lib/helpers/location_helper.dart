// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24KRuAYI';

class LocationHelper {
  static String generateLocationImage(double? longtiude, double? latitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtiude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtiude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse('');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
    //0 indx bec it orderd by the most relevant loc
    //try the breakpoint here
  }
}
