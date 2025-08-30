import 'package:json_annotation/json_annotation.dart';
part 'user_entity.g.dart';

enum UserType { demandeur, porteur }
@JsonSerializable()
class UserEntity {
  final String? id;
  final String? name;
  final UserType? type;
  final String? email;
  final String? avatar;
  final DateTime? createdAt;

  UserEntity({
    this.id,
    this.name,
    this.type,
    this.email,
    this.avatar,
    this.createdAt,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    UserType? type,
    String? email,
    String? avatar,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,

      type: type ?? this.type,
    );
  }
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
