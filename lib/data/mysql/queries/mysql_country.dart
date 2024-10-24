import '../../../models/country.dart';
import '../../repository/repository.dart';
import '../mysql_db.dart';

class MySqlCountry extends Repository<Country>
{
  @override
  Future<Country> create(Country item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Country item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Country>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM paises');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Country(
         countryID: map['cod_pais'].toString(),
         countryName: map['nome'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(Country item) {
    // TODO: implement update
    throw UnimplementedError();
  }}