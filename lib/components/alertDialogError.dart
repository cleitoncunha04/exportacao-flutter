

import 'package:flutter/material.dart';

class AlertDialogError extends StatefulWidget {
  const AlertDialogError({Key? key}) : super(key: key);

  @override
  State<AlertDialogError> createState() => _AlertDialogErrorState();
}

class _AlertDialogErrorState extends State<AlertDialogError>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3750),
    );
    _rotationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_controller); 
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.3,
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
                    duration: const Duration(milliseconds: 1500),
                    tween: Tween<double>(begin: 40, end: 20),
                    builder: (context, value, child) {
                      return Text(
                        'ERROR',
                        style: TextStyle(
                          fontSize: value,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 2.0 * 3.14159,
                        child: child,
                      );
                    },
                    child: CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.red[600],
                      child: Icon(
                        Icons.clear_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
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
