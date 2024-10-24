import 'package:mysql_client/mysql_client.dart';
import 'package:projetinho_final/data/db.dart';
import 'package:projetinho_final/data/mysql/queries/mysql_account.dart';
import 'package:projetinho_final/data/mysql/queries/mysql_country.dart';
import 'package:projetinho_final/data/mysql/queries/mysql_fed_unit.dart';
import 'package:projetinho_final/data/mysql/queries/mysql_statistic_unit.dart';
import 'package:projetinho_final/data/mysql/queries/mysql_transactions.dart';
import 'package:projetinho_final/models/account.dart';
import 'package:projetinho_final/models/transaction.dart';

import '../../models/country.dart';
import '../../models/fed_unit.dart';
import '../../models/harbor.dart';
import '../../models/product.dart';
import '../../models/transit.dart';
import '../../models/statistic_unit.dart';
import 'queries/mysql_harbor.dart';
import 'queries/mysql_product.dart';
import 'queries/mysql_route.dart';

class MySqlDb extends Db {
  static Future<MySQLConnection> getConnection() async {
    var connection = await MySQLConnection.createConnection(
      host: 'localhost',
      port: 3306,
      userName: 'flutter',
      password: 'senha123',
      databaseName: 'exportacao',
    );
    await connection.connect();
    return connection;
  }

  @override
  Future<void> inicialize() async {
    Transaction.repository = MySqlTransaction();
    Country.repository = MySqlCountry();
    FederativeUnit.repository = MySqlFedUnit();
    Harbor.repository = MySqlHarbor();
    Product.repository = MySqlProduct();
    Transit.repository = MySqlTransit();
    StatisticUnit.repository = MySqlStatisticUnit();
    Adminstrator.repository = MySqlAccount();
  }
}

