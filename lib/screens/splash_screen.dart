

import 'package:flutter/material.dart';
import 'package:opos/screens/home_screen.dart';
import 'package:opos/widgets/rounded_button.dart';

/// SPLASH AL ABRIR LA APP Y CONTINUAR NAVEGANDO A HOME_SCREEN ///
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/wall1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logogc.png",
            fit: BoxFit.scaleDown,
            scale: 1.5,),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.display3,
                children: [
                  TextSpan(
                    text: "Opos",
                  ),
                  TextSpan(
                    text: "Test.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: RoundedButton(
                text: "comenzar",
                fontSize: 20,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();  /// NAVEGADOR A HOME_SCREEN
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
