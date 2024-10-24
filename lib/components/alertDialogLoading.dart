import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AlertDialogLoading extends StatefulWidget {
  const AlertDialogLoading({Key? key}) : super(key: key);

  @override
  State<AlertDialogLoading> createState() => _AlertDialogLoading();
}

class _AlertDialogLoading extends State<AlertDialogLoading> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            width: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 8),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    curve: Curves.bounceOut,
                    duration: Duration(milliseconds: 1500),
                    tween: Tween<double>(begin:12, end: 20),
                    builder: (context, value, child) {
                      return Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: value,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SpinKitFadingCube(
                    color: Colors.indigo[200],
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
