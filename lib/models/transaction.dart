import 'package:projetinho_final/data/repository/repository.dart';

class Transaction {
  final String transactionID;
  final double netKilogram;
  final double statQuantity;
  final double dollarValue;
  final String transactionCountryID;
  final String transactionTransitID;
  final String transactionHarborID;
  final String transactionFedUnitAcronym;
  final String transactionProductID;
  final DateTime transactionDate;

  Transaction({
    required this.transactionID,
    required this.netKilogram,
    required this.statQuantity,
    required this.dollarValue,
    required this.transactionCountryID,
    required this.transactionTransitID,
    required this.transactionHarborID,
    required this.transactionFedUnitAcronym,
    required this.transactionProductID,
    required this.transactionDate,
  });

  static Repository<Transaction>? repository;

  static Future<List<Transaction>> getAll() async {
    return await repository!.getAll();
  }

  Future<Transaction> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
