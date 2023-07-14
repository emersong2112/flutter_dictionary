import 'package:flutter/material.dart';
import 'package:flutter_dictionary/Pages/root.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF424242),
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF424242),
          ),
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      home: const RootPage(),
    );
  }
}
