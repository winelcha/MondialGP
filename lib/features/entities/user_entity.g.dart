// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  id: json['id'] as String?,
  name: json['name'] as String?,
  type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']),
  email: json['email'] as String?,
  avatar: json['avatar'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$UserTypeEnumMap[instance.type],
      'email': instance.email,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$UserTypeEnumMap = {
  UserType.demandeur: 'demandeur',
  UserType.porteur: 'porteur',
};
