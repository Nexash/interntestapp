import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:revision/apiFetchDisplay/apiModal.dart';

class apiFetch {
  static const String url = "https://dummyjson.com/prod";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    final code = response.statusCode;

    switch (code) {
      case 200:
        final Map<String, dynamic> data = json.decode(response.body);
        final List productJson = data['products'];

        return productJson.map((json) => Product.fromJson(json)).toList();

      case 400:
        throw Exception("Bad request (400)");

      case 401:
        throw Exception("Unauthorized (401)");

      case 403:
        throw Exception("Forbidden (403)");

      case 404:
        throw Exception("Not Found (404)");

      case 500 || 502 || 503:
        throw Exception("Server error ($code)");

      default:
        throw Exception("Unexpected status code: $code");
    }
  }
}
