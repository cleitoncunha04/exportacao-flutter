import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController txtEditPassword;
  PasswordTextField({
    super.key,
    required this.txtEditPassword,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool _isSenhaVisible = false;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isSenhaVisible ? false : true,
      controller: widget.txtEditPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text('Password...'),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: _isSenhaVisible
              ? Icon(
                  Icons.remove_red_eye_rounded,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Icon(
                  Icons.remove_red_eye_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          onPressed: () {
            setState(() {
              _isSenhaVisible = !_isSenhaVisible;
            });
          },
        ),
      ),
    );
  }
}
