// comment.dart
class Comment {
  final String id;
  final String userId; // assuming you have a user system
  final String content;

  Comment({
    required this.id,
    required this.userId,
    required this.content,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      userId: map['userId'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
    };
  }
}
