import 'package:hive_flutter/hive_flutter.dart';

class AlbumDetail {
  dynamic albumId;
  dynamic id;
  dynamic title;
  dynamic url;
  dynamic thumbnailUrl;

  AlbumDetail({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory AlbumDetail.fromJson(Map<String, dynamic> json) {
    return AlbumDetail(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class AlbumDetailAdapter extends TypeAdapter<AlbumDetail> {
  @override
  final typeId = 5;

  @override
  AlbumDetail read(BinaryReader reader) {
    return AlbumDetail()
      ..albumId = reader.read()
      ..id = reader.read()
      ..title = reader.read()
      ..url = reader.read()
      ..thumbnailUrl = reader.read();
  }

  @override
  void write(BinaryWriter writer, AlbumDetail obj) {
    writer.write(obj.albumId);
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.url);
    writer.write(obj.thumbnailUrl);
  }
}

