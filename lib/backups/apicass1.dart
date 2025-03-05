import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List users = [];
  Future<void> fetachUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      users = jsonDecode(response.body);
    } else {
      throw Exception("failed vai hoibo na");
    }
  }

  @override
  void initState() {
    super.initState();
    fetachUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: Text(
          "API",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 4,
              color: Colors.white70,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "A",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: Text((index + 1).toString()),
                title: Text(
                  user['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User name: ${user['username']}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Email: ${user['email']}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Phone: ${user['phone']}",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      user['website'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
