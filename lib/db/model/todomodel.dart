class TodoModel {
  String? title;
  String? todo;
  TodoModel({required this.title, required this.todo});
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(title: json["title"], todo: json["todo"]);
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "todo": todo};
  }
}
