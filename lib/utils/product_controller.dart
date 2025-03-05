import 'dart:convert';

import 'package:api_concepts/utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:api_concepts/model/product_model.dart';

class ProductController {
  List<Data> products = [];

  Future<bool> fetechProducts() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      ProductModel productModel = ProductModel.fromJson(data);
      products = productModel.data ?? [];

      return true;
    }
    return false;
  }

  Future<void> createProduct(
      String name, String img, int qty, int price, int totalPrice) async {
    final response = await http.post(Uri.parse(Urls.createProduct),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    // print(response.body.toString());
    if (response.statusCode == 201) {
      await fetechProducts();
    }
  }

  Future<void> updateProduct(String id, String name, String img, int qty,
      int price, int totalPrice) async {
    final response = await http.post(Uri.parse(Urls.updateProduct(id)),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice
        }));

    // print(response.body.toString());
    if (response.statusCode == 201) {
      await fetechProducts();
    }
  }

  Future<bool> deleteProduct(String id) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));

    // print(response.body.toString());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // end of the code
}
