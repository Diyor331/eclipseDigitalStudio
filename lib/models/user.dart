import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class User {
  dynamic id;
  dynamic name;
  dynamic username;

  User({
    this.id,
    this.name,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User()
      ..id = reader.read()
      ..name = reader.read()
      ..username = reader.read();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.username);
  }
}
