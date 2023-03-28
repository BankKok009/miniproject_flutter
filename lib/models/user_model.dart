// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String type;
  final String address;
  final String phone;
  final String user;
  final String password;
  final String avatar;
  UserModel({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.phone,
    required this.user,
    required this.password,
    required this.avatar,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? type,
    String? address,
    String? phone,
    String? user,
    String? password,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      user: user ?? this.user,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'address': address,
      'phone': phone,
      'user': user,
      'password': password,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, type: $type, address: $address, phone: $phone, user: $user, password: $password, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.address == address &&
      other.phone == phone &&
      other.user == user &&
      other.password == password &&
      other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      user.hashCode ^
      password.hashCode ^
      avatar.hashCode;
  }
}
