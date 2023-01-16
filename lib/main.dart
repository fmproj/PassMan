import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passman/data/password.dart';
import 'package:passman/screens/login_screen.dart';
import 'package:passman/screens/register_screen.dart';
import 'package:passman/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PassMan',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}

Future<void> _initHive() async {
  const encryptionKeyName = 'SuperAwesomeEncryptionKeyForSecureStorage';

  await Hive.initFlutter();

  const storage = FlutterSecureStorage();
  final String? encryptionKey = await storage.read(key: encryptionKeyName);
  if (encryptionKey == null) {
    final key = Hive.generateSecureKey();
    await storage.write(
      key: encryptionKeyName,
      value: base64UrlEncode(key),
    );
  }

  final key = await storage.read(key: encryptionKeyName);
  final encryptionKeyBytes = base64Url.decode(key!);
  Hive.registerAdapter(PasswordAdapter());
  await Hive.openBox<Password>(
    'passwords',
    encryptionCipher: HiveAesCipher(encryptionKeyBytes),
  );
}
