import '../data/repository/repository.dart';

class Harbor {
  final String harborID;
  final String harborDescription;

  Harbor({
    required this.harborID,
    required this.harborDescription,
  });

  static Repository<Harbor>? repository;

  static Future<List<Harbor>> getAll() async {
    return await repository!.getAll();
  }

  Future<Harbor> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
