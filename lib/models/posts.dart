import 'package:hive_flutter/hive_flutter.dart';

class Posts {
  dynamic userId;
  dynamic id;
  dynamic title;
  dynamic body;

  Posts({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class PostsAdapter extends TypeAdapter<Posts> {
  @override
  final typeId = 2;

  @override
  Posts read(BinaryReader reader) {
    return Posts()
      ..userId = reader.read()
      ..id = reader.read()
      ..title = reader.read()
      ..body = reader.read();
  }

  @override
  void write(BinaryWriter writer, Posts obj) {
    writer.write(obj.userId);
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.body);
  }
}