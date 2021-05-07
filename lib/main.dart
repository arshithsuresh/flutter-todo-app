import 'package:flutter/material.dart';
import 'package:todoapp/views/homePage.dart';
import 'package:todoapp/views/splashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(        
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.redAccent,   
        iconTheme: IconThemeData(color: Colors.white)
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage()
      },
    );
  }
}



