import 'package:opos/constants.dart';
import 'package:opos/widgets/rating_widget.dart';
import 'package:opos/widgets/two_side_rounded_button.dart';
import 'package:flutter/material.dart';
import '../tests/mono_test.dart';


/// WIDGET DE TARJETAS POR TEMAS DEL MENU PRINCIPAL USADO EN HOME_SCREEN  ///

class tarjetaTema extends StatefulWidget {
  @override
  var id;
  String image;
  String title;
  String tema;
  String auth;
  double rating;
  Function pressDetails;
  Function pressRead;
  double record;


  tarjetaTema({Key key, this.image, this.title, this.tema, this.auth, this.rating, this.id}) : super(key: key);
  _tarjetaTemaState createState() => _tarjetaTemaState(image,title,tema,auth,rating,id);
}

class _tarjetaTemaState extends State<tarjetaTema> {
  var id;
  String image;
  String title;
  String tema;
  String auth;
  double rating;
  Function pressDetails;
  Function pressRead;
  double record;

  _tarjetaTemaState(image,title,tema,auth,rating,id);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class TarjetaTema extends StatelessWidget {
  final int id;
  final String portada;
  final String nombre_tema;
  final String tema;
  final String tipo_tema;
  double rating;
  final Function pressDetails;
  final Function pressRead;
  double record;


  TarjetaTema({
    Key key,
    this.id,
    this.portada,
    this.nombre_tema,
    this.tema,
    this.tipo_tema,
    this.record,
    this.rating,
    this.pressDetails,
    this.pressRead,

  }) : super(key: key);


/// WIDGET TARJETAS SELECTORAS DE TEMA VISTO EN UI DE HOME_SCREEN///
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            portada,
            width: 150,
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                widget_rating(tema: tema,),
              ],
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "$nombre_tema\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: tipo_tema,
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: pressDetails,
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("Temas"),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Examen",
                          press: () {
                            return showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      actions: <Widget>[
                                        Column(
                                          children: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute( /// NAVEGADOR A MONO_TEST PASANDO nombretema / corregirendirecto / multiplestemas ///
                                                    builder: (context) => monotest(tema,id, true, true),
                                                  ),
                                                );
                                              },
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 55, 0),
                                              child: Text(
                                                'Corrección en directo',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 115, 80),
                                                  fontWeight: FontWeight.w700,

                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(/// NAVEGADOR A MONO_TEST PASANDO nombretema / corregirluego / multiplestemas //
                                                    builder: (context) => monotest(tema,id, false, false),
                                                  ),
                                                );
                                              },
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 50, 0),
                                              child: Text(
                                                'Corregir al finalizar',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 115, 80),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                          }
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
