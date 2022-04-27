import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/utilities/constants.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String decodedData = response.body;
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
