import 'package:flutter/material.dart';
import 'package:projetinho_final/components/alertDialogLoading.dart';
import 'package:projetinho_final/models/country.dart';
import 'package:projetinho_final/models/fed_unit.dart';
import 'package:projetinho_final/models/harbor.dart';
import 'package:projetinho_final/models/product.dart';
import 'package:projetinho_final/models/transaction.dart';
import 'package:projetinho_final/models/transit.dart';

import '../components/alertDialogError.dart';
import '../components/autoComplete.dart';
import '../components/datePicker.dart';
import 'homePage.dart';

var appBar = AppBar(
  title: Text('Add an transaction:'),
);

List<String> _productsName = [];
List<String> _countriesName = [];
List<String> _fedUnitsName = [];
List<String> _harborsName = [];
List<String> _routesName = [];

TextEditingController txtEditCtrProduct = TextEditingController();
TextEditingController txtEditCtrStUnit = TextEditingController();
TextEditingController txtEditCtrStQnty = TextEditingController();
TextEditingController txtEditCtrNetKg = TextEditingController();
TextEditingController txtEditCtrDolarV = TextEditingController();
TextEditingController txtEditCtrFedUnit = TextEditingController();
TextEditingController txtEditCtrHarbor = TextEditingController();
TextEditingController txtEditCtrTransit = TextEditingController();
TextEditingController txtEditCtrCountry = TextEditingController();

DateTime _selectedDate = DateTime.now();

class AddPage extends StatefulWidget {
  final bool isUpdate;
  final Transaction? updatedTransaction;
  final String btnText;
  final List<Transaction> transactions;
  final List<Product> products;
  final List<Country> countries;
  final List<FederativeUnit> fedUnits;
  final List<Harbor> harbors;
  final List<Transit> routes;
  AddPage(
      {super.key,
      required this.isUpdate,
      this.updatedTransaction,
      required this.btnText,
      required this.transactions,
      required this.products,
      required this.countries,
      required this.fedUnits,
      required this.harbors,
      required this.routes});

  @override
  State<AddPage> createState() => _AddPageState();
}

bool isInserted = false;

class _AddPageState extends State<AddPage> {
  

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    setState(() {
      _productsName =
          widget.products.map((pr) => pr.productDescription).toList();
      _countriesName = widget.countries.map((cr) => cr.countryName).toList();
      _fedUnitsName = widget.fedUnits.map((fedU) => fedU.fedUnitName).toList();
      _harborsName = widget.harbors.map((hb) => hb.harborDescription).toList();
      _routesName = widget.routes.map((rt) => rt.routeDescription).toList();
    });
    print(_productsName.length);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now(),
    ).then((slDate) {
      if (slDate == null) {
        return 1;
      }
      setState(() {
        _selectedDate = slDate;
        print(_selectedDate);
      });
    });
  }

  _createTransaction() async {
    print(txtEditCtrProduct.text);

    var trProductID = widget.products.firstWhere(
        (pr) => pr.productDescription.contains(txtEditCtrProduct.text));
    var trCountryID = widget.countries
        .firstWhere((cr) => cr.countryName.contains(txtEditCtrCountry.text));
    var trTransitID = widget.routes.firstWhere(
        (tr) => tr.routeDescription.contains(txtEditCtrTransit.text));
    var trHarborID = widget.harbors.firstWhere(
        (hb) => hb.harborDescription.contains(txtEditCtrHarbor.text));
    var trFedUnitAcr = widget.fedUnits.firstWhere(
        (fedU) => fedU.fedUnitName.contains(txtEditCtrFedUnit.text));

    Transaction transaction;

    try {
      transaction = Transaction(
        transactionID: '',
        netKilogram: double.parse(txtEditCtrNetKg.text),
        statQuantity: double.parse(txtEditCtrStQnty.text),
        dollarValue: double.parse(txtEditCtrDolarV.text),
        transactionCountryID: trCountryID.countryID,
        transactionTransitID: trTransitID.routeID,
        transactionHarborID: trHarborID.harborID,
        transactionFedUnitAcronym: trFedUnitAcr.fedUnitAcronym,
        transactionProductID: trProductID.productID,
        transactionDate: _selectedDate,
      );
      transaction = await transaction.create();

      setState(() {
        transaction;
      });
    } catch (e) {
      // _errorDialog();
    }
  }

  _updateTransaction() async {
    print(txtEditCtrProduct.text);

    var trProductID = widget.products.firstWhere(
        (pr) => pr.productDescription.contains(txtEditCtrProduct.text));
    var trCountryID = widget.countries
        .firstWhere((cr) => cr.countryName.contains(txtEditCtrCountry.text));
    var trTransitID = widget.routes.firstWhere(
        (tr) => tr.routeDescription.contains(txtEditCtrTransit.text));
    var trHarborID = widget.harbors.firstWhere(
        (hb) => hb.harborDescription.contains(txtEditCtrHarbor.text));
    var trFedUnitAcr = widget.fedUnits.firstWhere(
        (fedU) => fedU.fedUnitName.contains(txtEditCtrFedUnit.text));
    Transaction transaction;

    try {
      transaction = Transaction(
        transactionID: widget.updatedTransaction!.transactionID,
        netKilogram: double.parse(txtEditCtrNetKg.text),
        statQuantity: double.parse(txtEditCtrStQnty.text),
        dollarValue: double.parse(txtEditCtrDolarV.text),
        transactionCountryID: trCountryID.countryID,
        transactionTransitID: trTransitID.routeID,
        transactionHarborID: trHarborID.harborID,
        transactionFedUnitAcronym: trFedUnitAcr.fedUnitAcronym,
        transactionProductID: trProductID.productID,
        transactionDate: _selectedDate,
      );
      transaction = await transaction.update();

      setState(() {
        transaction;
      });
    } catch (e) {
      // _errorDialog();
    }
  }

  _cleanFields() {
    txtEditCtrStUnit.text = '';
    txtEditCtrStQnty.text = '';
    txtEditCtrDolarV.text = '';
    txtEditCtrNetKg.text = '';
    _selectedDate = DateTime.now();
  }

  // _errorDialog() async {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       context = context;
  //       return const AlertDialogError();
  //     },
  //   );
  //   await Future.delayed(Duration(milliseconds: 1000));

  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.sizeOf(context).height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: availableHeight,
        margin: EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.00625,
                ),
                AutoComplete(
                  listWords: _productsName,
                  textFieldLabel: 'Products...',
                  prefixIcon: Icon(Icons.shopify_rounded),
                  textEditingController: txtEditCtrProduct,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 2,
                        controller: txtEditCtrStUnit,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Statistic Unit...'),
                          prefixIcon: Icon(Icons.pie_chart_rounded),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.025,
                    ),
                    Expanded(
                      child: TextField(
                        controller: txtEditCtrStQnty,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Statistic Quantity...'),
                          prefixIcon:
                              Icon(Icons.production_quantity_limits_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                TextField(
                  controller: txtEditCtrNetKg,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Net Kilogram...'),
                    prefixIcon: Icon(Icons.balance_rounded),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                TextField(
                  controller: txtEditCtrDolarV,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Dollar value...'),
                    prefixIcon: Icon(Icons.attach_money_rounded),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                AutoComplete(
                  listWords: _fedUnitsName,
                  textFieldLabel: 'Ferative Unit...',
                  prefixIcon: Icon(Icons.location_city_rounded),
                  textEditingController: txtEditCtrFedUnit,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                AutoComplete(
                  listWords: _harborsName,
                  textFieldLabel: 'Harbor...',
                  prefixIcon: Icon(Icons.directions_boat_filled_rounded),
                  textEditingController: txtEditCtrHarbor,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                AutoComplete(
                  listWords: _routesName,
                  textFieldLabel: 'Transit...',
                  prefixIcon: Icon(Icons.directions_bus_rounded),
                  textEditingController: txtEditCtrTransit,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                AutoComplete(
                  listWords: _countriesName,
                  textFieldLabel: 'Destiny Country...',
                  prefixIcon: Icon(Icons.add_location_alt_rounded),
                  textEditingController: txtEditCtrCountry,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                DatePicker(
                    selectedDate: _selectedDate, dtPicker: _showDatePicker),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        context = context;
                        return const AlertDialogLoading();
                      },
                    );
                    await Future.delayed(const Duration(milliseconds: 1500));
                    Navigator.pop(context);

                    if (!widget.isUpdate) {
                      _createTransaction();
                    } else {
                      _updateTransaction();
                    }

                    _cleanFields();
                    
                    List<Transaction> tr = await Transaction.getAll();

                    //  if (isInserted) {
                      

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            transactions: tr,
                            countries: widget.countries,
                            products: widget.products,
                            fedUnits: widget.fedUnits,
                            harbors: widget.harbors,
                            routes: widget.routes,
                            isLogged: true,
                          ),
                        ),
                      );
                    //  } else {
                    //   _errorDialog();
                    //   Navigator.pop(context);

                    //    MaterialPageRoute(
                    //       builder: (context) => HomePage(
                    //         transactions: tr,
                    //         countries: widget.countries,
                    //         products: widget.products,
                    //         fedUnits: widget.fedUnits,
                    //         harbors: widget.harbors,
                    //         routes: widget.routes,
                    //         isLogged: true,
                    //       ),
                    //     );
                    //  }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      bottom: 20,
                      top: 15,
                      left: 30,
                      right: 30,
                    ),
                  ),
                  child: Text(
                    widget.btnText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
