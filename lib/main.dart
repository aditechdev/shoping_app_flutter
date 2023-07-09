import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/providers/cart_provider.dart';
import 'package:shoping_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartProvider(),
      child: MaterialApp(
          title: "Shoping App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: "Lato",
              appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  centerTitle: true),
              inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  prefixIconColor: Color.fromRGBO(119, 119, 119, 1)),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(254, 206, 1, 1),
                primary: const Color.fromRGBO(254, 206, 1, 1),
              ),
              textTheme: const TextTheme(
                titleMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                bodySmall: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                titleLarge: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              useMaterial3: true),
          home: const HomePage()
          // home: const HomePage(),
          ),
    );
  }
}
