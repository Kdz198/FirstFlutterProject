import 'package:flutter/material.dart';
import 'package:prmwtf/screen/ToDoScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt cái chữ Debug đỏ ở góc
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TodoScreen(), // <--- Quan trọng: Gọi TodoScreen ở đây
    );
  }
}