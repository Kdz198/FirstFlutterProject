class ToDo {
  String id;
  String title;
  bool isCompleted; // Biến này thay đổi được nên không để final

  // Constructor
  // required: Bắt buộc phải truyền (như @NotNull)
  ToDo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
