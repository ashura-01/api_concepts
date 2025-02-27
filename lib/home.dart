import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: Text("API",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),

      body: Center(child: Text("halo halo"),),
    );
  }
  
}