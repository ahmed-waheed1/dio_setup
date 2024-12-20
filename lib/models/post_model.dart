class PostModel {
  final String title;
  final int id;
  final int userId;
  final String body;

  PostModel({
    required this.title,
    required this.id,
    required this.userId,
    required this.body,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] as String,
      id: json['id'] as int,
      userId: json['userId'] as int,
      body: json['body'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'userId': userId,
      'body': body,
    };
  }
}
