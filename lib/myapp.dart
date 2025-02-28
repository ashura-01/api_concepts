// import 'package:api_concepts/apicass1.dart';
import 'apiclass2.dart';
import 'package:flutter/material.dart';

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Apiclass2(),
    );
  }
  
}