class Task {
  String? id;
  String? title;
  String? description;
  int? date;
  int? time;
  bool? isDone;

  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.isDone = false,
  });

  Task.fromFiresore(Map<String, dynamic>? data)
    : this(
        id: data?['id'],
        title: data?['title'],
        description: data?['description'],
        date: data?['date'],
        time: data?['time'],
        isDone: data?['isDone'],
      );

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "isDone": isDone,
    };
  }
}
