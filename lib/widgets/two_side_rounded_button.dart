import 'package:opos/constants.dart';
import 'package:flutter/material.dart';


///este es el boton de dos colores de la ui///


class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radious;
  final Function press;
  const TwoSideRoundedButton({
    Key key,
    this.text,
    this.radious = 29,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kBlackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
