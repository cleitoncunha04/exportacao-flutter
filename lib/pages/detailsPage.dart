import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetinho_final/models/charValue.dart';
import 'package:projetinho_final/models/statistic_unit.dart';

import '../models/country.dart';
import '../models/fed_unit.dart';
import '../models/harbor.dart';
import '../models/product.dart';
import '../models/transaction.dart';
import '../models/transit.dart';

class DetailsPage extends StatefulWidget {
  final Transaction transaction;
  final List<Product> products;
  final List<Country> countries;
  final List<FederativeUnit> fedUnits;
  final List<Harbor> harbors;
  final List<Transit> routes;
  const DetailsPage({
    super.key,
    required this.transaction,
    required this.products,
    required this.countries,
    required this.fedUnits,
    required this.harbors,
    required this.routes,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Product? product;
  StatisticUnit? stUnit;
  Country? country;
  FederativeUnit? fedUnit;
  Harbor? harbor;
  Transit? transit;
  List<ChartValue>? recentValues;

  @override
  void initState() {
    super.initState();
    setState(() {
      _getValues();
    });
  }

  _getValues() async {
    List<StatisticUnit> stUnits = await StatisticUnit.getAll();

    product = widget.products.firstWhere(
        (pr) => pr.productID.contains(widget.transaction.transactionProductID));
    stUnit = stUnits
        .firstWhere((stU) => stU.stUnitID.contains(product!.productStUnit));
    country = widget.countries.firstWhere(
        (ct) => ct.countryID.contains(widget.transaction.transactionCountryID));
    fedUnit = widget.fedUnits.firstWhere((fedU) => fedU.fedUnitAcronym
        .contains(widget.transaction.transactionFedUnitAcronym));
    harbor = widget.harbors.firstWhere(
        (hb) => hb.harborID.contains(widget.transaction.transactionHarborID));
    transit = widget.routes.firstWhere(
        (tr) => tr.routeID.contains(widget.transaction.transactionTransitID));

    setState(() {
      product;
      stUnit;
      country;
      fedUnit;
      harbor;
      transit;
      recentValues;
    });

    print(recentValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details:', style: TextStyle(fontSize: 25),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo[200]!,
              Colors.grey[200]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: product == null ||
                stUnit == null ||
                country == null ||
                fedUnit == null ||
                harbor == null ||
                transit == null
            ? Container()
            : Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 20,
                        offset: Offset(3, 9),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.black87,
                        thickness: 5,
                      ),
                      Text(
                        'Date: ' +
                            DateFormat('M/d/yyyy')
                                .format(widget.transaction.transactionDate),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(color: Colors.black87),
                      Text(
                        'Product: ${product!.productDescription}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'NCM code: ${widget.transaction.transactionProductID}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Statistic Quantity: ${widget.transaction.statQuantity} ${stUnit!.stUnitAcronym}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Net Kilogram: ${widget.transaction.netKilogram} NKG',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Dollar value: \$${widget.transaction.dollarValue.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(color: Colors.black87),
                      Text(
                        'Federative State: ${widget.transaction.transactionFedUnitAcronym}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(color: Colors.black87),
                      Text(
                        'Harbor: ${harbor!.harborDescription}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(color: Colors.black87),
                      Text(
                        'Transit: ${transit!.routeDescription}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(color: Colors.black87),
                      Text(
                        'Country: ${country!.countryName}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Divider(
                        color: Colors.black87,
                        thickness: 5,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
