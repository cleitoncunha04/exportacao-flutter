import 'package:projetinho_final/models/harbor.dart';

import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlHarbor extends Repository<Harbor>
{
  @override
  Future<Harbor> create(Harbor item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Harbor item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Harbor>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM porto');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Harbor(
          harborID: map['cod_porto'].toString(),
          harborDescription: map['descricao'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(Harbor item) {
    // TODO: implement update
    throw UnimplementedError();
  }}