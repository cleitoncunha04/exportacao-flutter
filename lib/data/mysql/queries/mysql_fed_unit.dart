import '../../../models/fed_unit.dart';
import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlFedUnit extends Repository<FederativeUnit>
{
  @override
  Future<FederativeUnit> create(FederativeUnit item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(FederativeUnit item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<FederativeUnit>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM estado');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return FederativeUnit(
          fedUnitAcronym: map['sigla'].toString(),
          fedUnitName: map['nome'].toString(),
          fedUnitRegion: map['regiao'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(FederativeUnit item) {
    // TODO: implement update
    throw UnimplementedError();
  }}