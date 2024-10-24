import 'package:flutter/material.dart';
import 'package:projetinho_final/pages/aboutUsPage.dart';
import 'package:projetinho_final/pages/accountPage.dart';
import 'package:projetinho_final/pages/addPage.dart';

import '../models/country.dart';
import '../models/fed_unit.dart';
import '../models/harbor.dart';
import '../models/navDrawerList.dart';
import '../models/product.dart';
import '../models/transaction.dart';
import '../models/transit.dart';
import '../pages/homePage.dart';

class NavDrawer extends StatelessWidget {
  final List<Transaction> transactions;
  final List<Product> products;
  final List<Country> countries;
  final List<FederativeUnit> fedUnits;
  final List<Harbor> harbors;
  final List<Transit> routes;
  final bool isLogged;
  NavDrawer({
    super.key,
    required this.transactions,
    required this.products,
    required this.countries,
    required this.fedUnits,
    required this.harbors,
    required this.routes,
    required this.isLogged,
  });

  final List<NavDrawerList> _navDrawerList = [
    NavDrawerList(
      drawerNameIcon: 'home',
      drawerText: 'Home',
    ),
    NavDrawerList(
      drawerNameIcon: 'person',
      drawerText: 'Account',
    ),
    NavDrawerList(
      drawerNameIcon: 'more_horiz_rounded',
      drawerText: 'About us...',
    ),
  ];

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'add':
        return Icons.add;
      case 'person':
        return Icons.person;
      case 'more_horiz_rounded':
        return Icons.more_horiz_rounded;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged) {
      final NavDrawerList addTransactionItem = NavDrawerList(
        drawerNameIcon: 'add',
        drawerText: 'Add a transaction',
      );
      _navDrawerList.insert(1, addTransactionItem);
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Icon(
                  Icons.account_circle,
                  size: MediaQuery.sizeOf(context).height * 0.3,
                  color: Colors.indigo[50],
                ),
                isLogged ? Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ) : Text(
                  'Guest',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            indent: 5,
            endIndent: 5,
            color: Theme.of(context).colorScheme.secondary,
            height: 30,
          ),
          Expanded(
            // Adiciona o Expanded
            child: ListView.builder(
              itemCount: _navDrawerList.length,
              itemBuilder: (ctx, index) {
                var nvL = _navDrawerList[index];

                IconData iconData = _getIconData(nvL.drawerNameIcon);

                return GestureDetector(
                  onTap: () async {
                    List<Transaction> tr = await Transaction.getAll();

                    nvL.drawerText == 'Home'
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage(
                                  transactions: tr,
                                  countries: countries,
                                  products: products,
                                  fedUnits: fedUnits,
                                  harbors: harbors,
                                  routes: routes,
                                  isLogged: isLogged,
                                )))
                        : nvL.drawerText == 'Add a transaction'
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddPage(
                                      btnText: 'Insert',
                                      isUpdate: false,
                                      transactions: transactions,
                                      countries: countries,
                                      products: products,
                                      fedUnits: fedUnits,
                                      harbors: harbors,
                                      routes: routes,
                                    )))
                            : nvL.drawerText == 'Account'
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AccountPage(
                                          isLogged: isLogged,
                                        )))
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AboutUsPage(
                                          transactions: transactions,
                                          countries: countries,
                                          fedUnits: fedUnits,
                                          harbors: harbors,
                                          products: products,
                                          routes: routes,
                                          isLogged: isLogged,
                                        )));
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Icon(
                        iconData,
                        color: Colors.indigo[50],
                      ),
                    ),
                    title: Text(
                      nvL.drawerText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
