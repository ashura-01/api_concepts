import 'dart:convert';

import 'package:api_concepts/utils/urls.dart';
import 'package:http/http.dart' as http;

class ProductController {
  List products = [];
  Future<void> fetechProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      products = data['data'];
    }
  }
}
