
import 'package:projetinho_final/models/account.dart';

import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlAccount extends Repository<Adminstrator>
{
  @override
  Future<Adminstrator> create(Adminstrator item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Adminstrator item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Adminstrator>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM administrador;');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Adminstrator(
         user: map['usuario'].toString(),
         password: map['senha'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(Adminstrator item) {
    // TODO: implement update
    throw UnimplementedError();
  }}