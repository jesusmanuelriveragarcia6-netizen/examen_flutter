import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<List<dynamic>> getData(String url, String accion) async {
    final response = await http.get(Uri.parse("$url?accion=$accion"));
    return json.decode(response.body);
  }

  static Future<bool> postData(String url, String accion, Map<String, String> body) async {
    final response = await http.post(Uri.parse("$url?accion=$accion"), body: body);
    return response.statusCode == 200;
  }
}
