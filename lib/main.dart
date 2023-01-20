import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passman/data/password.dart';
import 'package:passman/screens/home_screen.dart';
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
        '/home':(context) => const HomeScreen(),
      },
    );
  }
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  _initHiveEncryptedBoxWithType<Password>('passwords_encryption_key', 'passwords', PasswordAdapter());
  _initHiveEncryptedBox('credentials_encryption_key', 'credentials');
}

void _initHiveEncryptedBoxWithType<T>(String encryptionKeyName, String boxName, TypeAdapter<T> adapter) async {
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
  Hive.registerAdapter(adapter);
  await Hive.openBox<T>(
    boxName,
    encryptionCipher: HiveAesCipher(encryptionKeyBytes),
  );
}

void _initHiveEncryptedBox(String encryptionKeyName, String boxName) async {
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
  await Hive.openBox(
    boxName,
    encryptionCipher: HiveAesCipher(encryptionKeyBytes),
  );
}