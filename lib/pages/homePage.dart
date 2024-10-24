import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetinho_final/components/emptyList.dart';
import 'package:projetinho_final/components/navDrawer.dart';
import 'package:projetinho_final/models/product.dart';
import 'package:projetinho_final/models/transaction.dart';
import 'package:projetinho_final/pages/addPage.dart';
import 'package:projetinho_final/pages/detailsPage.dart';

import '../models/country.dart';
import '../models/fed_unit.dart';
import '../models/harbor.dart';
import '../models/transit.dart';

class HomePage extends StatefulWidget {
  final List<Transaction> transactions;
  final List<Product> products;
  final List<Country> countries;
  final List<FederativeUnit> fedUnits;
  final List<Harbor> harbors;
  final List<Transit> routes;
  final bool isLogged;
  
   HomePage({
    Key? key,
    required this.transactions,
    required this.products,
    required this.countries,
    required this.fedUnits,
    required this.harbors,
    required this.routes,
    required this.isLogged,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction>? _filteredTransactions;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
      List<Transaction> tr = await Transaction.getAll();
    setState(() {
      _filteredTransactions = tr;
    });

  }

  void _searchTransactions(String searchText) async {
    List<Transaction> tr = await Transaction.getAll();
    setState(() {
      if (searchText == '') {
        _filteredTransactions = tr;
      } else {
        _filteredTransactions = tr.where((transaction) {
          var product = widget.products.firstWhere(
            (pr) => pr.productID == transaction.transactionProductID,
            orElse: null,
          );
          return product.productDescription
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavDrawer(
        transactions: widget.transactions,
        countries: widget.countries,
        fedUnits: widget.fedUnits,
        harbors: widget.harbors,
        products: widget.products,
        routes: widget.routes,
        isLogged: widget.isLogged,
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Container()),
            widget.isLogged
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => AddPage(
                                  btnText: 'Insert',
                                  isUpdate: false,
                                  transactions: widget.transactions,
                                  countries: widget.countries,
                                  products: widget.products,
                                  fedUnits: widget.fedUnits,
                                  harbors: widget.harbors,
                                  routes: widget.routes,
                                )),
                      );
                    },
                    icon: Icon(Icons.add),
                  )
                : Container(),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo[200]!,
              Colors.grey[100]!,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black54,
                    offset: Offset(2, 6),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (searchText) {
                  _searchTransactions(searchText);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(),
                  labelText: 'Search...',
                  suffixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            _filteredTransactions == null || _filteredTransactions!.isEmpty
                ? EmptyList()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _filteredTransactions!.length,
                      itemBuilder: (context, index) {
                        var tr = _filteredTransactions![index];
                        var product = widget.products.firstWhere(
                          (pr) => pr.productID == tr.transactionProductID,
                        );
                        var country = widget.countries.firstWhere(
                          (ct) => ct.countryID == tr.transactionCountryID,
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  transaction: tr,
                                  countries: widget.countries,
                                  products: widget.products,
                                  fedUnits: widget.fedUnits,
                                  harbors: widget.harbors,
                                  routes: widget.routes,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              title: Text(product.productDescription),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${country.countryName}, ' +
                                      DateFormat('M/d/yyyy')
                                          .format(tr.transactionDate)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Text(
                                      'Value: \$${tr.dollarValue.toStringAsFixed(2)}'),
                                ],
                              ),
                              trailing: Container(
                                width: MediaQuery.sizeOf(context).width * 0.1,
                                height: MediaQuery.sizeOf(context).height,
                                child: widget.isLogged
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                Colors.indigoAccent,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPage(
                                                      btnText: 'Update',
                                                      isUpdate: true,
                                                      updatedTransaction: tr,
                                                      transactions:
                                                          widget.transactions,
                                                      countries:
                                                          widget.countries,
                                                      products: widget.products,
                                                      fedUnits: widget.fedUnits,
                                                      harbors: widget.harbors,
                                                      routes: widget.routes,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.create,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            child: IconButton(
                                              onPressed: () async {
                                                tr.delete();
                                                setState(() {
                                                  _filteredTransactions!
                                                      .remove(tr);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete_forever_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: widget.isLogged,
        child: FloatingActionButton(
          hoverColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddPage(
                        btnText: 'Insert',
                        isUpdate: false,
                        transactions: widget.transactions,
                        countries: widget.countries,
                        products: widget.products,
                        fedUnits: widget.fedUnits,
                        harbors: widget.harbors,
                        routes: widget.routes,
                      )),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
