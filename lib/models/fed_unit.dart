import '../data/repository/repository.dart';

class FederativeUnit {
  final String fedUnitAcronym;
  final String fedUnitName;
  final String fedUnitRegion;

  FederativeUnit({
    required this.fedUnitAcronym,
    required this.fedUnitName,
    required this.fedUnitRegion, 
  });

  static Repository<FederativeUnit>? repository;

  static Future<List<FederativeUnit>> getAll() async {
    return await repository!.getAll();
  }

  Future<FederativeUnit> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
