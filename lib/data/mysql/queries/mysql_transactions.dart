import 'package:projetinho_final/data/repository/repository.dart';
import 'package:projetinho_final/models/charValue.dart';
import 'package:projetinho_final/models/transaction.dart';

import '../mysql_db.dart';

class MySqlTransaction extends Repository<Transaction> {
  @override
  Future<Transaction> create(Transaction transaction) async {
    var connection = await MySqlDb.getConnection();

    try {
      await connection.execute('''
      CALL insercao(:dateTr, :stQuantTr, :netKgTr, :dolarValueTr, 
        :ctrCodTr, :codProdTr, :codHarbTr, :codTransitTr, :fedUnitAcrTr);''', {
        'dateTr': transaction.transactionDate,
        'stQuantTr': transaction.statQuantity,
        'netKgTr': transaction.netKilogram,
        'dolarValueTr': transaction.dollarValue,
        'ctrCodTr': int.parse(transaction.transactionCountryID),
        'codProdTr': int.parse(transaction.transactionProductID),
        'codHarbTr': int.parse(transaction.transactionHarborID),
        'codTransitTr': int.parse(transaction.transactionTransitID),
        'fedUnitAcrTr': transaction.transactionFedUnitAcronym,
      });

    } catch (e) {
      print(e);
    }

    await connection.close();

    return transaction;
  }

  @override
  Future<void> delete(Transaction item) async {
    var conexao = await MySqlDb.getConnection();
    await conexao.execute('''
DELETE FROM venda 
WHERE id_venda = :idTr
''', {
      'idTr': item.transactionID,
    });
  }

  @override
  Future<List<Transaction>> getAll() async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute('SELECT * FROM venda');

    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return Transaction(
          transactionID: map['id_venda'].toString(),
          transactionDate: DateTime.parse(map['data_venda']),
          statQuantity: (map['quantidade_estatistica'] + 0.0) as double,
          netKilogram: map['kg_liquido'],
          dollarValue: map['valor_dolar'],
          transactionCountryID: map['paises_cod'].toString(),
          transactionProductID: map['produtos_cod'].toString(),
          transactionFedUnitAcronym: map['estado_sg'].toString(),
          transactionHarborID: map['porto_cod'].toString(),
          transactionTransitID: map['via_cod'].toString(),
        );
      },
    ).toList();
  }

  @override
  Future<void> update(Transaction transaction) async {
    var connection = await MySqlDb.getConnection();

    try {
      await connection.execute('''
      CALL edicao(:idTr, :dateTr, :stQuantTr, :netKgTr, :dolarValueTr, 
        :ctrCodTr, :codProdTr, :codHarbTr, :codTransitTr, :fedUnitAcrTr);''', {
        'idTr': transaction.transactionID,
        'dateTr': transaction.transactionDate,
        'stQuantTr': transaction.statQuantity,
        'netKgTr': transaction.netKilogram,
        'dolarValueTr': transaction.dollarValue,
        'ctrCodTr': int.parse(transaction.transactionCountryID),
        'codProdTr': int.parse(transaction.transactionProductID),
        'codHarbTr': int.parse(transaction.transactionHarborID),
        'codTransitTr': int.parse(transaction.transactionTransitID),
        'fedUnitAcrTr': transaction.transactionFedUnitAcronym,
      });
    } catch (e) {
      print(e);
    }

    await connection.close();
  }

  static Future<List<ChartValue>> getValuesFromSomeProduct(int trID) async {
    var connection = await MySqlDb.getConnection();
    var result = await connection.execute(
      'call getValuesFromSomeProduct(2);',
      {

      },
    );

    await connection.close();
    return result.rows.map(
      (row) {
        var map = row.typedAssoc();
        return ChartValue(
          month: map['mes'],
          stQtd: (map['sumQtEst'] + 0.0) as double,
          netKg: (map['sumKG'] + 0.0) as double,
          dollarValue: (map['sumDollar'] + 0.0) as double,
        );
      },
    ).toList();
  }
}
