import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loca_app/users/authentication/login_screen.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Loca App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /*
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
         */
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder(future: null, builder: (context, dataSnapshot) { return LoginScreen(); }
      ),
    );
  }
}
