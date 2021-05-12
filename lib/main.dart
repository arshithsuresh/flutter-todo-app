import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/views/homePage.dart';
import 'package:todoapp/views/splashScreen.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firebase.initializeApp().asStream(),
        builder: (context, snapshot) {

          if(snapshot.hasError)
              print("Error!");

          if (snapshot.connectionState == ConnectionState.done)
            return MaterialApp(
              title: 'My ToDo App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.lightBlue,
                  accentColor: Colors.redAccent,
                  iconTheme: IconThemeData(color: Colors.white)),
              initialRoute: '/',
              routes: {
                '/': (context) => SplashScreen(),
                '/home': (context) => HomePage()
              },
            );

            return CircularProgressIndicator();
        }
        
         
        
        );
  }
}
