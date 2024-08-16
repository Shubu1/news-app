import 'package:equatable/equatable.dart';
import 'package:news_connect/src/entities/user_entity.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String age;
  const MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.age});
  static const empty = MyUser(userId: "", email: "", name: "", age: "");
  MyUser copyWith({String? userId, String? email, String? name, String? age}) {
    return MyUser(
        age: age ?? this.age,
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name);
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
        age: age ?? this.age,
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        age: entity.age,
        userId: entity.userId,
        email: entity.email,
        name: entity.name);
  }

  @override
  List<Object?> get props => [userId, email, name, age];
}
