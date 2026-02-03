import 'package:flutter/material.dart';
import '../model/ToDo.dart';
import '../service/ToDoService.dart';
import 'SecondScreen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();

  List<ToDo> _displayTodos = [];

  final TextEditingController _textController = TextEditingController();

  // Hàm chạy 1 lần khi màn hình khởi tạo (Giống @PostConstruct)
  @override
  void initState() {
    super.initState();
    _refreshList(); // Load dữ liệu lần đầu
  }

  // Hàm lấy data mới nhất từ Service và báo UI vẽ lại
  void _refreshList() {
    setState(() {
      // Gọi service lấy list
      _displayTodos = _todoService.getAllTodos();
    });
  }

  // Xử lý thêm mới
  void _handleAddTodo() {
    // Hiển thị một cái Popup (Dialog) để nhập tên task
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm việc mới'),
          content: TextField(
            controller: _textController, // Gắn controller để lấy text user nhập
            decoration: const InputDecoration(hintText: "Nhập tên công việc..."),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng dialog
                _textController.clear(); // Xóa text cũ
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  // Gọi Service thêm mới
                  // ID truyền tạm rỗng '' vì service của bạn sẽ tự set lại ID
                  ToDo newTodo = ToDo(id: '', title: _textController.text);
                  _todoService.addTodo(newTodo);

                  _refreshList(); // Reload lại list

                  _textController.clear(); // Xóa text
                  Navigator.pop(context); // Đóng dialog
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  // Xử lý xóa
  void _handleDelete(String id) {
    _todoService.deleteTodo(id);
    _refreshList(); // Xóa xong nhớ refresh
  }

  // Xử lý toggle (checkbox)
  void _handleToggle(String id) {
    _todoService.toggleTodoStatus(id);
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List (RAM)"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios), // Icon mũi tên
            onPressed: () {
              // Điều hướng đến SecondScreen khi nhấn nút
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
          ),
          // Nút 2: Lọc
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),

          // Nút 3: Setting (Thêm cái này nhìn cho ngầu)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate sang màn hình Setting...
            },
          ),

        ],
      ),

      body: ListView.builder(
        itemCount: _displayTodos.length,
        itemBuilder: (context, index) {
          // Lấy ra item thứ index
          final todo = _displayTodos[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              // Checkbox bên trái
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (value) => _handleToggle(todo.id),
              ),

              // Tên công việc
              title: Text(
                todo.title,
                style: TextStyle(
                  // Nếu xong thì gạch ngang, chưa xong thì bình thường
                  decoration: todo.isCompleted ? TextDecoration.overline : null,
                  color: todo.isCompleted ? Colors.grey : Colors.black,
                ),
              ),

              // Nút xóa bên phải
              trailing: IconButton(
                icon: const Icon(Icons.stacked_bar_chart, color: Colors.red),
                onPressed: () => _handleDelete(todo.id),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddTodo,
        child: const Icon(Icons.remember_me),
      ),


        bottomNavigationBar : BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 50.0,
          child: Center(
            child: Text('Hoang Tu Gio FPT EVC', style: TextStyle(color: Colors.white, fontSize: 16) ),
          ),        ),



    )
    );

  }
}