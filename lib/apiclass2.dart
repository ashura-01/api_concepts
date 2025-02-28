import 'package:flutter/material.dart';

class Apiclass2 extends StatefulWidget {
  const Apiclass2({super.key});

  @override
  State<Apiclass2> createState() => _Apiclass2State();
}

class _Apiclass2State extends State<Apiclass2> {
  void productDialouge() {
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
                    decoration: InputDecoration(labelText: "Product Name")),
                TextField(
                    decoration: InputDecoration(labelText: "Product Code")),
                TextField(
                    decoration: InputDecoration(labelText: "Product Image")),
                TextField(
                    decoration: InputDecoration(labelText: "Product Qty")),
                TextField(
                    decoration:
                        InputDecoration(labelText: "Product Unit Price")),
                TextField(
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
                    // Add product logic here before closing the dialog
                    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text("Productes"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
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
                        "Iphone 15",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text("Price: \$500 | Qty: 20"),
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
        onPressed: ()=>productDialouge(),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
