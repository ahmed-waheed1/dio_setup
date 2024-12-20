class PostRequest {
  final String title;
  final String body;
  final int userId = 1;

  PostRequest({required this.title, required this.body});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
