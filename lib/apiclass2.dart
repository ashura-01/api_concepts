import 'package:api_concepts/utils/product_controller.dart';
import 'package:flutter/material.dart';

class Apiclass2 extends StatefulWidget {
  const Apiclass2({super.key});

  @override
  State<Apiclass2> createState() => _Apiclass2State();
}

class _Apiclass2State extends State<Apiclass2> {
  final ProductController productControllerObject = ProductController();

  void productDialouge() {
    TextEditingController nameController = TextEditingController();
    // TextEditingController codeController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController qtyController = TextEditingController();
    TextEditingController unitPriceController = TextEditingController();
    TextEditingController totalPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("Add Product"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Product Name")),
                TextField(
                    controller: imageController,
                    decoration: InputDecoration(labelText: "Product Image")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: qtyController,
                    decoration: InputDecoration(labelText: "Product Qty")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: unitPriceController,
                    decoration:
                        InputDecoration(labelText: "Product Unit Price")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: totalPriceController,
                    decoration: InputDecoration(labelText: "Total Price")),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Close dialog
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: Text("Cancel"),
                ),
                SizedBox(width: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      productControllerObject.createProduct(
                          nameController.text,
                          imageController.text,
                          int.parse(qtyController.text),
                          int.parse(unitPriceController.text),
                          int.parse(totalPriceController.text));
                      fetchData();
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text("Add Product"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10)), // Adjusted to 10
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    await productControllerObject.fetechProducts();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text("Products"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productControllerObject.products.length,
                itemBuilder: (context, index) {
                  var product = productControllerObject.products[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ListTile(
                      leading: Image.network(
                        "https://shorturl.at/0yPd2",
                        height: 50,
                        width: 50,
                      ),
                      title: Text(
                        product['ProductName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                          "Price: \$${product['UnitPrice']} | Qty: ${product['Qty']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => productDialouge(),
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => productDialouge(),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
