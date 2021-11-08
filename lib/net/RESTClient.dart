import 'package:http/http.dart' as http;

class RESTClient {

  static Future<String> get(String url) async {
    var response = await http.get(url);
    return response.body;
  }
}