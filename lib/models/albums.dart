import 'package:hive_flutter/hive_flutter.dart';

class Albums {
  dynamic userId;
  dynamic id;
  dynamic title;

  Albums({
    this.userId,
    this.id,
    this.title,
  });

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class AlbumsAdapter extends TypeAdapter<Albums> {
  @override
  final typeId = 4;

  @override
  Albums read(BinaryReader reader) {
    return Albums()
      ..userId = reader.read()
      ..id = reader.read()
      ..title = reader.read();
  }

  @override
  void write(BinaryWriter writer, Albums obj) {
    writer.write(obj.userId);
    writer.write(obj.id);
    writer.write(obj.title);
  }
}
