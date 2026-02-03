// lib/screens/second_screen.dart
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar cho trang thứ 2 (để có nút Back tự động)
      appBar: AppBar(
        title: const Text("Màn hình 2"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "Hello this is second screen",
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
      ),
    );
  }
}