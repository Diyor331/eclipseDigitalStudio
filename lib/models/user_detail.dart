import 'package:hive_flutter/hive_flutter.dart';

class UserDetail {
  dynamic id;
  dynamic name;
  dynamic username;
  dynamic email;
  dynamic address;
  dynamic phone;
  dynamic website;
  dynamic company;

  UserDetail({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      website: json['website'],
      company: json['company'],
    );
  }
}

class UserDetailAdapter extends TypeAdapter<UserDetail> {
  @override
  final typeId = 1;

  @override
  UserDetail read(BinaryReader reader) {
    return UserDetail()
      ..id = reader.read()
      ..name = reader.read()
      ..username = reader.read()
      ..email = reader.read()
      ..address = reader.read()
      ..phone = reader.read()
      ..website = reader.read()
      ..company = reader.read();
  }

  @override
  void write(BinaryWriter writer, UserDetail obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.username);
    writer.write(obj.email);
    writer.write(obj.address);
    writer.write(obj.phone);
    writer.write(obj.website);
    writer.write(obj.company);
  }
}