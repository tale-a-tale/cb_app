import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String description;
  final String userId;
  final String documentId;

  Post({
    @required this.userId,
    @required this.title,
    @required this.description,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
    };
  }

  static Post fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      description: map['description'],
      userId: map['userId'],
      documentId: documentId,
    );
  }
}