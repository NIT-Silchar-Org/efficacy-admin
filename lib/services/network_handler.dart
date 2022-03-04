import 'package:efficacy_admin/constant/endpoints.dart';
import 'package:http/http.dart' as http;

class NetworkEngine {
  
  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    var response = await http.post(
            Uri.parse(baseUrl),
            headers: {
                "Content-type": "application/json",
            },
            body: body
        );
    return response;
  }
}
