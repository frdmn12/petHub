class Forum {
  final String id;
  final String? name;
  final String? email;
  final String category;
  final String content;
  final String uid;

  Forum({
    required this.id,
    this.name,
    this.email,
    required this.category,
    required this.content,
    required this.uid,
  });

  factory Forum.fromMap(Map<String, dynamic> map) {
    return Forum(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      category: map['category'],
      content: map['content'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'category': category,
      'content': content,
      'uid': uid,
    };
  }

  static Forum fromJson(Map<String, dynamic> json) => Forum(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      category: json['category'],
      content: json['content'],
      uid: json['uid']);
}
