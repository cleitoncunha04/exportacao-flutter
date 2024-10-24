import 'package:projetinho_final/data/mysql/mysql_db.dart';
import 'package:projetinho_final/models/product.dart';

import '../../repository/repository.dart';

class MySqlProduct extends Repository<Product> {
  @override
  Future<Product> create(Product item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Product item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM produtos');
    
    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Product(
          productID: map['cod_prod'].toString(),
          productDescription: map['descricao'],
          productStUnit: map['unid_cod'].toString(),
        );
      },
    ).toList();
  }



  @override
  Future<void> update(Product item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
