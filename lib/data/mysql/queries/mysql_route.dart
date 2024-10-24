import 'package:projetinho_final/models/transit.dart';

import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlTransit extends Repository<Transit>
{
  @override
  Future<Transit> create(Transit item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Transit item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Transit>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM via');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Transit(
          routeID: map['cod_via'].toString(),
          routeDescription: map['transporte'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(Transit item) {
    // TODO: implement update
    throw UnimplementedError();
  }}