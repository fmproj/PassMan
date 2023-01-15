import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('PassMan'),
            SizedBox(height: 50,),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
