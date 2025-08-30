import 'dart:ui';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:untitled/ui/styles/styles.dart';
part 'annonce_entity.g.dart';

enum AnnonceStatus { preparing, inTransit, delivered, cancelled }

@JsonSerializable()
class AnnonceEntity {
  final String? id;
  final String? origin;
  final String? destination;
  final double weight;
  final double pricePerKg;
  final String? gpName;
  final AnnonceStatus status;
  final DateTime? dateCreated;
  final DateTime? dateDelivered;
  final String? qrCode;
  final String? pinCode;
  final List<String> photos;
  final UserEntity? demandeur;
  final UserEntity? porteur;

  AnnonceEntity({
     this.id,
     this.origin,
     this.destination,
     required this.weight,
     required this.pricePerKg,
     this.gpName,
     required this.status,
     this.dateCreated,
     this.demandeur,
    this.dateDelivered,
    this.qrCode,
    this.pinCode,
    this.photos = const [],
    this.porteur,
  });

  double get totalPrice => weight * pricePerKg;

  String get statusText {
    switch (status) {
      case AnnonceStatus.preparing:
        return 'À préparer';
      case AnnonceStatus.inTransit:
        return 'En transit';
      case AnnonceStatus.delivered:
        return 'Livré';
      case AnnonceStatus.cancelled:
        return 'Annulé';
    }
  }

  Color get statusColor {
    switch (status) {
      case AnnonceStatus.preparing:
        return AppColors.orange;
      case AnnonceStatus.inTransit:
        return AppColors.orange;
      case AnnonceStatus.delivered:
        return AppColors.green;
      case AnnonceStatus.cancelled:
        return AppColors.red;
    }
  }

  Map<String, dynamic> toJson() => _$AnnonceEntityToJson(this);

  factory AnnonceEntity.fromJson(Map<String, dynamic> json) =>
      _$AnnonceEntityFromJson(json);
}
