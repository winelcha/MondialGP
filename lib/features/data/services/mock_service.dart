import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/features/entities/user_entity.dart';

class MockService extends GetxService {
  final List<UserEntity> _users = [];
  final List<AnnonceEntity> _annonces = [];

  Future<MockService> init() async {
    _generateMockData();
    return this;
  }

  void _generateMockData() {
    _users.addAll([
      UserEntity(
        id: '1',
        name: 'Marie Dupont',
        type: UserType.demandeur,
        email: 'marie@example.com',
      ),
      UserEntity(
        id: '2',
        name: 'Jean Martin',
        type: UserType.porteur,
        email: 'jean@example.com',
      ),
      UserEntity(
        id: '3',
        name: 'Sophie Bernard',
        type: UserType.porteur,
        email: 'sophie@example.com',
      ),
      UserEntity(
        id: '4',
        name: 'Pierre Durand',
        type: UserType.demandeur,
        email: 'pierre@example.com',
      ),
    ]);

    _annonces.addAll([
      AnnonceEntity(
        id: '1',
        origin: 'France',
        destination: 'Cameroun',
        weight: 5.0,
        pricePerKg: 12.50,
        gpName: 'GP Express Paris',
        status: AnnonceStatus.preparing,
        dateCreated: DateTime.now().subtract(Duration(days: 2)),
        demandeur: _users[0],
      ),
      AnnonceEntity(
        id: '2',
        origin: 'France',
        destination: 'Sénégal',
        weight: 10.0,
        pricePerKg: 10.00,
        gpName: 'GP Mondial Lyon',
        status: AnnonceStatus.inTransit,
        dateCreated: DateTime.now().subtract(Duration(days: 5)),
        demandeur: _users[3],
        porteur: _users[1],
      ),
      AnnonceEntity(
        id: '3',
        origin: 'France',
        destination: 'Côte d\'Ivoire',
        weight: 2.5,
        pricePerKg: 15.00,
        gpName: 'GP International',
        status: AnnonceStatus.delivered,
        dateCreated: DateTime.now().subtract(Duration(days: 10)),
        dateDelivered: DateTime.now().subtract(Duration(days: 1)),
        demandeur: _users[0],
        porteur: _users[2],
      ),
      AnnonceEntity(
        id: '4',
        origin: 'France',
        destination: 'Mali',
        weight: 7.5,
        pricePerKg: 11.00,
        gpName: 'GP Rapide',
        status: AnnonceStatus.preparing,
        dateCreated: DateTime.now().subtract(Duration(hours: 12)),
        demandeur: _users[3],
      ),
    ]);
  }

  Future<List<AnnonceEntity>> getAnnonces() async {
    await Future.delayed(Duration(milliseconds: 800)); // Simulation latence
    return List.from(_annonces);
  }

  Future<AnnonceEntity?> getAnnonceById(String id) async {
    await Future.delayed(Duration(milliseconds: 300));
    try {
      return _annonces.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateAnnonceStatus(String id, AnnonceStatus newStatus) async {
    await Future.delayed(Duration(milliseconds: 1000));

    final index = _annonces.indexWhere((a) => a.id == id);
    if (index != -1) {
      final oldAnnonce = _annonces[index];
      _annonces[index] = AnnonceEntity(
        id: oldAnnonce.id,
        origin: oldAnnonce.origin,
        destination: oldAnnonce.destination,
        weight: oldAnnonce.weight,
        pricePerKg: oldAnnonce.pricePerKg,
        gpName: oldAnnonce.gpName,
        status: newStatus,
        dateCreated: oldAnnonce.dateCreated,
        demandeur: oldAnnonce.demandeur,
        porteur: oldAnnonce.porteur,
        dateDelivered: newStatus == AnnonceStatus.delivered
            ? DateTime.now()
            : oldAnnonce.dateDelivered,
        qrCode: oldAnnonce.qrCode,
        pinCode: oldAnnonce.pinCode,
        photos: oldAnnonce.photos,
      );
      return true;
    }
    return false;
  }


  static List<AnnonceEntity> getMockAnnonces() {
    return [
      AnnonceEntity(
        id: '1',
        origin: 'France',
        destination: 'Sénégal',
        weight: 5.0,
        pricePerKg: 12.50,
        gpName: 'Air France',
        status: AnnonceStatus.preparing,
        dateCreated: DateTime.now().subtract(const Duration(days: 2)),
        demandeur: UserEntity(
          id: '1',
          name: 'Marie Dupont',
          type: UserType.demandeur,
          email: 'marie@email.com',
        ),
        porteur: UserEntity(
          id: '2',
          name: 'Jean Martin',
          type: UserType.porteur,
          email: 'jean@email.com',
        ),
      ),
      AnnonceEntity(
        id: '2',
        origin: 'France',
        destination: 'Cameroun',
        weight: 3.2,
        pricePerKg: 15.00,
        gpName: 'Turkish Airlines',
        status: AnnonceStatus.inTransit,
        dateCreated: DateTime.now().subtract(const Duration(days: 1)),
        demandeur: UserEntity(
          id: '3',
          name: 'Sophie Bernard',
          type: UserType.demandeur,
          email: 'sophie@email.com',
        ),
        porteur: UserEntity(
          id: '4',
          name: 'Paul Durand',
          type: UserType.porteur,
          email: 'paul@email.com',
        ),
      ),
      AnnonceEntity(
        id: '3',
        origin: 'France',
        destination: 'Mali',
        weight: 8.5,
        pricePerKg: 10.00,
        gpName: 'Brussels Airlines',
        status: AnnonceStatus.delivered,
        dateCreated: DateTime.now().subtract(const Duration(days: 5)),
        dateDelivered: DateTime.now().subtract(const Duration(days: 1)),
        demandeur: UserEntity(
          id: '5',
          name: 'Fatou Diallo',
          type: UserType.demandeur,
          email: 'fatou@email.com',
        ),
        porteur: UserEntity(
          id: '6',
          name: 'Amadou Ba',
          type: UserType.porteur,
          email: 'amadou@email.com',
        ),
      ),
      AnnonceEntity(
        id: '4',
        origin: 'France',
        destination: 'Côte d\'Ivoire',
        weight: 2.8,
        pricePerKg: 18.00,
        gpName: 'Air Côte d\'Ivoire',
        status: AnnonceStatus.preparing,
        dateCreated: DateTime.now().subtract(const Duration(hours: 6)),
        demandeur: UserEntity(
          id: '7',
          name: 'Koffi Yao',
          type: UserType.demandeur,
          email: 'koffi@email.com',
        ),
      ),
    ];
  }

  static String generateMockQRCode() {
    return 'MONDIAL_GP_${DateTime.now().millisecondsSinceEpoch}';
  }

  static String generateMockPINCode() {
    return (1000 + (DateTime.now().millisecondsSinceEpoch % 9000)).toString();
  }




  String generateQRCode() {
    return 'MondialGP_${DateTime.now().millisecondsSinceEpoch}';
  }
  String generatePinCode() {
    return (1000 + (DateTime.now().millisecondsSinceEpoch % 9000)).toString();
  }
}



