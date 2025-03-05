import 'package:api_concepts/utils/product_controller.dart';
import 'package:flutter/material.dart';

class Apiclass2 extends StatefulWidget {
  const Apiclass2({super.key});

  @override
  State<Apiclass2> createState() => _Apiclass2State();
}

class _Apiclass2State extends State<Apiclass2> {
  final ProductController productControllerObject = ProductController();

  mySnackBar(messege, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(messege)));
  }

  void showLoadingScreen(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,  
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void hideLoadingScreen(BuildContext context) {
  Navigator.of(context).pop();  // Close the loading dialog
}

  void productDialouge(
      {String? id,
      String? name,
      int? qty,
      String? img,
      int? unitPrice,
      int? totalPrice}) {
    TextEditingController nameController =
        TextEditingController(text: name ?? '');
    TextEditingController imageController =
        TextEditingController(text: img ?? '');
    TextEditingController qtyController =
        TextEditingController(text: qty?.toString() ?? '0');
    TextEditingController unitPriceController =
        TextEditingController(text: unitPrice?.toString() ?? '0');
    TextEditingController totalPriceController =
        TextEditingController(text: totalPrice?.toString() ?? '0');

    // nameController.text = name ?? '';
    // qtyController.text = qty.toString() ?? '0';
    // imageController.text = img ?? '';
    // unitPriceController.text = unitPrice.toString() ?? '0';
    // totalPriceController.text = totalPrice.toString() ?? '0';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text((id == null) ? "Add Product" : "Edit product"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: "Product Name")),
                TextField(
                    controller: imageController,
                    decoration:
                        const InputDecoration(labelText: "Product Image")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: qtyController,
                    decoration:
                        const InputDecoration(labelText: "Product Qty")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: unitPriceController,
                    decoration:
                        const InputDecoration(labelText: "Product Unit Price")),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: totalPriceController,
                    decoration:
                        const InputDecoration(labelText: "Total Price")),
                const SizedBox(height: 40),
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
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (id == null) {
                      productControllerObject.createProduct(
                        nameController.text,
                        imageController.text,
                        int.parse(qtyController.text),
                        int.parse(unitPriceController.text),
                        int.parse(totalPriceController.text),
                      );
                    } else {
                      productControllerObject.updateProduct(
                        id,
                        nameController.text,
                        imageController.text,
                        int.parse(qtyController.text),
                        int.parse(unitPriceController.text),
                        int.parse(totalPriceController.text),
                      );
                    }
                    //fetchData();
                    setState(() {});

                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 500), () {
                      fetchData();
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text((id == null) ? "Add Product" : "update product"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
    print("Fetching data...");
    await productControllerObject.fetechProducts();
    print("Data fetched: ${productControllerObject.products}");
    setState(() {}); 
  }

  @override
  void initState() {
    super.initState();
    
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text("Products"),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: ListTile(
                      leading: Image.network(
                        product.img ?? "https://shorturl.at/0yPd2",
                        height: 50,
                        width: 50,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                      title: Text(
                        product.productName.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                          "Price: \$${product.unitPrice} | Qty: ${product.qty}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => productDialouge(
                                    id: product.sId,
                                    name: product.productName,
                                    img: product.img,
                                    qty: product.qty,
                                    unitPrice: product.unitPrice,
                                    totalPrice: product.totalPrice,
                                  ),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                productControllerObject
                                    .deleteProduct(product.sId.toString())
                                    .then((value) {
                                  if (value) {
                                    setState(() {
                                      fetchData();
                                    });
                                    mySnackBar("Producte deleted", context);
                                  } else {
                                    mySnackBar("Something went wrong", context);
                                  }
                                });

                                setState(() {});
                              },
                              icon: const Icon(Icons.delete)),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
