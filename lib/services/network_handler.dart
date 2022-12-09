import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkEngine {
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-type": "application/json",
        },
        body: json.encode(body));
    return response;
  }
}
