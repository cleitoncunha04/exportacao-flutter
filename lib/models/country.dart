import '../data/repository/repository.dart';

class Country {
  final String countryID;
  final String countryName;

  Country({
    required this.countryID,
    required this.countryName,
  });

  static Repository<Country>? repository;

  static Future<List<Country>> getAll() async {
    return await repository!.getAll();
  }

  Future<Country> create() async {
    return await repository!.create(this);
  }

update() async {
     await repository!.update(this);
  }

delete() async {
     await repository!.delete(this);
  }
}
