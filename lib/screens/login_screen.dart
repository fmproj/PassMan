import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Password textfield
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                }),
              ),
              // Submit button
              ElevatedButton(
                onPressed: _onLoginSubmit,
                child: const Text('Login'),
              ),
            ],
          )),
    );
  }

  void _onLoginSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final credentials = Hive.box('credentials');
      if (credentials.get('password') == _passwordController.text) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      return null;
    }
  }
}
