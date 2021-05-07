import 'package:flutter/material.dart';

/*
  This page contains the first page that will open when our app starts
  A Simple way to add a SplashScreen to out app, but not the correct way.
  For now let's keep things Simple.
*/

class SplashScreen extends StatelessWidget {

  // The whole page is declared as a stateless widget, which means the UI won't be rendered with user's
  // Input. This is more than enough for a splash screen since we dont have any UI Components that require
  // the UI to re-render.

  @override
  Widget build(BuildContext context) {  
    // The build function is where a widget will render its UI Components
    // This will be called everytime we want to re-render the UI.

    return Scaffold(  //Scaffold is a simple page that implements the material design
      body: screenContent(context),
    );
  }

  Widget screenContent(context) {
    return Container(         // We create a container for storing our page's content
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 48, top: 120),
      child: Column(          // We use a column widget to display our page and its components in a column fashion
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image(
                image: AssetImage('assets/images/logo/logo.png'),
                // AssetImage is used when we want to display an image when it is in our asset folder
                // NetworkImage is used to display images from the internet
              ),
              Text(
                "ToDo List",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              Text(
                "Awesome ToDo List",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
              ),
            ],
          ),
          ElevatedButton(
              // ElevatedButton is a simple button that the user can click.
              // we use this button to navigate to the next page.
              style: ElevatedButton.styleFrom(
                // Setting the color of the button 
                primary: Colors.green,
                elevation: 0,
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, right: 40, left: 40),
              ),
              onPressed: () {
                // Navigator is used to do navigation in Flutter
                // PushedNamed function is used to navigate to the psage when mentioned
                // Works similar to website url
                Navigator.pushNamed(context, '/home');

              },
              child: Text(
                "Go >>",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}
