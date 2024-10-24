import '../../../models/statistic_unit.dart';
import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlStatisticUnit extends Repository<StatisticUnit>
{
  @override
  Future<StatisticUnit> create(StatisticUnit item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(StatisticUnit item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<StatisticUnit>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM unidade');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return StatisticUnit(
         stUnitID: map['cod_unid'].toString(),
         stUnitName: map['medida'].toString(),
         stUnitAcronym: map['sigla'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(StatisticUnit item) {
    // TODO: implement update
    throw UnimplementedError();
  }}