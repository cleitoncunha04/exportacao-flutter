import 'package:flutter/material.dart';
import 'package:projetinho_final/components/alertDialogLoading.dart';
import 'package:projetinho_final/models/account.dart';
import 'package:projetinho_final/models/country.dart';
import 'package:projetinho_final/models/product.dart';
import 'package:projetinho_final/models/transaction.dart';
import 'package:projetinho_final/pages/homePage.dart';

import '../components/alertDialogError.dart';
import '../components/passwordTextField.dart';
import '../models/fed_unit.dart';
import '../models/harbor.dart';
import '../models/transit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEditUser = TextEditingController();
  TextEditingController txtEditPassword = TextEditingController();

  List<Product>? _products;

  List<Country>? _countries;

  List<FederativeUnit>? _fedUnits;

  List<Harbor>? _harbors;

  List<Transit>? _routes;

  List<Transaction>? _transactions;

  List<Adminstrator>? _accounts;

  @override
  Widget build(BuildContext context) {
    _getData() async {
      _products = await Product.getAll();
      _countries = await Country.getAll();
      _fedUnits = await FederativeUnit.getAll();
      _harbors = await Harbor.getAll();
      _routes = await Transit.getAll();
      _transactions = await Transaction.getAll();
      _accounts = await Adminstrator.getAll();

      setState(() {
        _products;
        _countries;
        _fedUnits;
        _harbors;
        _routes;
        _transactions;
        _accounts;
      });
    }

    // bool _verifyAccount() {
    //   bool isOK = false;
    //   if(txtEditUser.text != '' && txtEditPassword.text != '')
    //   {
    //     isOK = _accounts!.any((ac) => ac.user == txtEditUser.text && ac.password == txtEditPassword.text);
    //   }

    //   return isOK;
    // }
    bool _verifyAccount() {
      if (txtEditUser.text.isNotEmpty && txtEditPassword.text.isNotEmpty) {
        return _accounts?.any((ac) =>
                ac.user == txtEditUser.text &&
                ac.password == txtEditPassword.text) ??
            false;
      }
      return false;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.grey[300]!,
            Colors.indigo[200]!,
          ],
        )),
        child: Center(
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black54,
                    offset: Offset(3, 8),
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.025,
              ),
              Icon(
                Icons.directions_boat_filled_rounded,
                size: 150,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.025,
              ),
              TextField(
                controller: txtEditUser,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Username...'),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              PasswordTextField(
                txtEditPassword: txtEditPassword,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.025,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          context = context;
                          return const AlertDialogLoading();
                        },
                      );

                      await _getData();

                      setState(() {});

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                transactions: _transactions!,
                                countries: _countries!,
                                products: _products!,
                                fedUnits: _fedUnits!,
                                harbors: _harbors!,
                                routes: _routes!,
                                isLogged: false,
                              )));
                    },
                    child: Text("Don't have an account?"),
                  )
                ],
              ),
              Expanded(child: Container()),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      context = context;
                      return const AlertDialogLoading();
                    },
                  );
                  await _getData();

                  bool isAccount = _verifyAccount();

                  if (isAccount) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              transactions: _transactions!,
                              countries: _countries!,
                              products: _products!,
                              fedUnits: _fedUnits!,
                              harbors: _harbors!,
                              routes: _routes!,
                              isLogged: true,
                            )));
                  } else {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        context = context;
                        return const AlertDialogError();
                      },
                    );
                    await Future.delayed(Duration(milliseconds: 1000));

                    Navigator.pop(context);
                  }

                  // await Future.delayed(const Duration(milliseconds: 2000));
                  // Navigator.pop(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: 30,
                    right: 30,
                    top: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.025,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
