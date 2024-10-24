import 'package:projetinho_final/data/repository/repository.dart';

class Adminstrator {
  final String user;
  final String password;

  Adminstrator({
    required this.user,
    required this.password,
  });

  static Repository<Adminstrator>? repository;

  static Future<List<Adminstrator>> getAll() async {
    return await repository!.getAll();
  }

  Future<Adminstrator> create() async {
    return await repository!.create(this);
  }

  update() async {
    await repository!.update(this);
  }

  delete() async {
    await repository!.delete(this);
  }
}
