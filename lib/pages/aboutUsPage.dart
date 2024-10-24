import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projetinho_final/components/navDrawer.dart';
import 'package:projetinho_final/models/transaction.dart';

import '../models/country.dart';
import '../models/fed_unit.dart';
import '../models/harbor.dart';
import '../models/product.dart';
import '../models/transit.dart';

class AboutUsPage extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Product> products;
  final List<Country> countries;
  final List<FederativeUnit> fedUnits;
  final List<Harbor> harbors;
  final List<Transit> routes;
  final bool isLogged;
  const AboutUsPage({
    super.key,
    required this.transactions,
    required this.products,
    required this.countries,
    required this.fedUnits,
    required this.harbors,
    required this.routes,
    required this.isLogged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        transactions: transactions,
        countries: countries,
        fedUnits: fedUnits,
        harbors: harbors,
        products: products,
        routes: routes,
        isLogged: isLogged,
      ),
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.indigo[200]!,
              Colors.grey,
            ])),
        child: Center(
          child: Container(
            height: 600,
            width: 700,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black54,
                    offset: Offset(6, 12),
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ABOUT US',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'This is a project of Programming Language II from SDA\'s course on IFSP Capivari-SP, Brazil.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '     The project is focused on the management and visualization of export data from Brazil, allowing the insertion of new sales by the administrator who must be using a registered account. Users who do not have it will only have access to view the information, with the possibility of filtering it according to their preferences.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Expanded(child: Container()),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(text: 'Software developed by '),
                            TextSpan(
                                text: 'Cleiton dos Santos Cunha ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: 'and '),
                            TextSpan(
                                text: 'João Victor de Sousa Prates.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
