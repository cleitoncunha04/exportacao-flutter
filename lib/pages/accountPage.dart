import 'package:flutter/material.dart';
import 'package:projetinho_final/components/alertDialogLogout.dart';
import 'package:projetinho_final/pages/loginPage.dart';

class AccountPage extends StatelessWidget {
  final bool isLogged;
  const AccountPage({
    super.key,
    required this.isLogged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: 650,
            width: 600,
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
            child: isLogged
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: MediaQuery.sizeOf(context).height * 0.25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(text: 'You are logged in as an  '),
                            TextSpan(
                                text: 'administrator',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: '...'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialogLogout(),
                          );
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                          ),
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
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        maxRadius: MediaQuery.sizeOf(context).height * 0.15,
                        child: Icon(
                          Icons.person_2_outlined,
                          size: MediaQuery.sizeOf(context).height * 0.25,
                          color: Colors.white,
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(text: 'You are '),
                            TextSpan(
                              text: 'not ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: 'logged in as an '),
                            TextSpan(
                                text: 'administrator',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: '...'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                          ),
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
