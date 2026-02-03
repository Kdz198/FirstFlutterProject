
import '../model/ToDo.dart';

class TodoService {

  final List<ToDo> todoList = [
    ToDo(id: '1', title: 'Học Dart cơ bản'),
    ToDo(id: '2', title: 'Viết Service Layer'),
    ToDo(id: '3', title: 'Làm quen UI Flutter', isCompleted: true),
  ];

  //Read
  List<ToDo> getAllTodos() {
    return todoList;
  }

  void addTodo(ToDo todo) {

    int newId = todoList.length + 1;
    todo.id = newId.toString();

    todoList.add(todo);
  }

  void toggleTodoStatus(String id) {
    for (ToDo todo in todoList) {
      if (todo.id == id) {
        todo.isCompleted = !todo.isCompleted;
        break;
      }
    }
  }

  // ==================== DELETE ====================
  void deleteTodo(String id) {
    // removeWhere: Xóa tất cả phần tử thỏa mãn điều kiện
    // (item) => ... là Lambda Expression (Arrow Function)
    todoList.removeWhere((item) => item.id == id);
  }
}