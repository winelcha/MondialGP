// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnonceEntity _$AnnonceEntityFromJson(Map<String, dynamic> json) =>
    AnnonceEntity(
      id: json['id'] as String?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      weight: (json['weight'] as num).toDouble(),
      pricePerKg: (json['pricePerKg'] as num).toDouble(),
      gpName: json['gpName'] as String?,
      status: $enumDecode(_$AnnonceStatusEnumMap, json['status']),
      dateCreated:
          json['dateCreated'] == null
              ? null
              : DateTime.parse(json['dateCreated'] as String),
      demandeur:
          json['demandeur'] == null
              ? null
              : UserEntity.fromJson(json['demandeur'] as Map<String, dynamic>),
      dateDelivered:
          json['dateDelivered'] == null
              ? null
              : DateTime.parse(json['dateDelivered'] as String),
      qrCode: json['qrCode'] as String?,
      pinCode: json['pinCode'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      porteur:
          json['porteur'] == null
              ? null
              : UserEntity.fromJson(json['porteur'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnonceEntityToJson(AnnonceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'origin': instance.origin,
      'destination': instance.destination,
      'weight': instance.weight,
      'pricePerKg': instance.pricePerKg,
      'gpName': instance.gpName,
      'status': _$AnnonceStatusEnumMap[instance.status]!,
      'dateCreated': instance.dateCreated?.toIso8601String(),
      'dateDelivered': instance.dateDelivered?.toIso8601String(),
      'qrCode': instance.qrCode,
      'pinCode': instance.pinCode,
      'photos': instance.photos,
      'demandeur': instance.demandeur,
      'porteur': instance.porteur,
    };

const _$AnnonceStatusEnumMap = {
  AnnonceStatus.preparing: 'preparing',
  AnnonceStatus.inTransit: 'inTransit',
  AnnonceStatus.delivered: 'delivered',
  AnnonceStatus.cancelled: 'cancelled',
};
