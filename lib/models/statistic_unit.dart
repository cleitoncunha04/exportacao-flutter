import '../data/repository/repository.dart';

class StatisticUnit {
  final String stUnitID;
  final String stUnitName;
  final String stUnitAcronym;

  StatisticUnit({
    required this.stUnitID,
    required this.stUnitName,
    required this.stUnitAcronym,
  });

  static Repository<StatisticUnit>? repository;

  static Future<List<StatisticUnit>> getAll() async {
    return await repository!.getAll();
  }

  Future<StatisticUnit> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
