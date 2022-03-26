import 'dart:convert';

import 'package:http/http.dart' as http;



class HttpServices {
  Future<Map<String, dynamic>?> get(String url) async {
    try {
      Uri _uri = Uri.parse(url);
      http.Response response = await http.get(_uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;
        final data = jsonDecode(body) as Map<String, dynamic>;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final HttpServices httpServices = HttpServices();
