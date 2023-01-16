import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // First password textfield
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required field';
                }
                return null;
              },
            ),
            // Confirmation password textfield
            TextFormField(
              controller: _passwordCheckController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required field';
                }
                return null;
              },
            ),
            // Submit button
            ElevatedButton(
              onPressed: _onRegisterSubmit,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _onRegisterSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text == _passwordCheckController.text) {
        final credentials = Hive.box('credentials');
        credentials.put('username', 'user');
        credentials.put('password', _passwordController.text);
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }
}
