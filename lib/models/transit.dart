import '../data/repository/repository.dart';

class Transit {
  final String routeID;
  final String routeDescription;

  Transit({
    required this.routeID,
    required this.routeDescription,
  });

  static Repository<Transit>? repository;

  static Future<List<Transit>> getAll() async {
    return await repository!.getAll();
  }

  Future<Transit> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
