// import 'package:api_integration/Screens/home.dart';
import 'package:api_integration/Screens/call_screen.dart';
import 'package:api_integration/Screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Api Integration',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      initialRoute: '/call',
      routes: {
        '/test': (context) => const TestScreen(),
        '/call': (context) => const CallScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

