import 'package:begining/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
class ProductAPI {
  Future<List<Product>> fetchProducts() async {
  final String apiUrl = "${dotenv.env['BASE_URL']}/api/v1/product/all";

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {"accept": "*/*"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      print("data: $data");
      return data.map((item) => Product.fromMap(item)).toList();
    } else {
      print("Error: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Exception: $e");
    return [];
  }
}

}