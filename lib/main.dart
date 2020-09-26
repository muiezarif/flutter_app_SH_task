import 'package:flutter/material.dart';
import 'package:flutterappdemotask/bloc/AuthBloc.dart';
import 'package:flutterappdemotask/screens/LoginScreen.dart';
import 'package:flutterappdemotask/screens/ProfileScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/profile': (context) => ProfileScreen()
        },
      ),
    );
  }
}
