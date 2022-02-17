import 'package:hive_flutter/hive_flutter.dart';

class PostDetail {
  dynamic postId;
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic body;

  PostDetail({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
class PostDetailAdapter extends TypeAdapter<PostDetail> {
  @override
  final typeId = 3;

  @override
  PostDetail read(BinaryReader reader) {
    return PostDetail()
      ..id = reader.read()
      ..postId = reader.read()
      ..name = reader.read()
      ..email = reader.read()
      ..body = reader.read();
  }

  @override
  void write(BinaryWriter writer, PostDetail obj) {
    writer.write(obj.postId);
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.email);
    writer.write(obj.body);
  }
}
