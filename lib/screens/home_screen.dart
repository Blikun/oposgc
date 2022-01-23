import 'package:opos/constants.dart';
import 'package:opos/screens/details_screen.dart';
import 'package:opos/tests/multi_test.dart';
import 'package:opos/widgets/tema_card_list.dart';
import 'package:opos/widgets/two_side_rounded_button.dart';
import 'package:flutter/material.dart';


/// UI DEL MENU PRINCIPAL ///

class HomeScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/main_page_bg.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.display1,
                        children: [
                          TextSpan(text: "¿Que quieres  \n   aprender "),
                          TextSpan(
                              text: "hoy?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        TarjetaTema( ///todo: añadir los temas a un json y que los saque de ahí. esto es código de testeo
                          portada: "images/book-1.png",
                          nombre_tema: "1 · Derechos Humanos",
                          tipo_tema: "Bloque único",
                          tema: "derechoshumanos",
                          id: 1,
                          pressDetails: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen();
                                },
                              ),
                            );
                          },
                        ),
                        TarjetaTema(
                          portada: "images/book-2.png",
                          nombre_tema: "2 · Igualdad",
                          tipo_tema: "Bloque único",
                          tema: "igualdad",
                          id: 2,
                        ),
                        TarjetaTema(
                          portada: "images/book-2.png",
                          nombre_tema: "3 · Prevencion R.L.",
                          tipo_tema: "Bloque único",
                          tema: "prevencionriesgoslaborales",
                          id: 3,
                        ),

                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.display1,
                            children: [
                              TextSpan(text: "Simular "),
                              TextSpan(
                                text: "examen",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        TarjetaDestacadaCentral(size, context),


                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: Color(0xFFD3D3D3).withOpacity(.84),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(

                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Reanudar Test",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Simulacro Examen G.C. 2021",
                                                style: TextStyle(
                                                  color: kLightBlackColor,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "60% Completado",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: kLightBlackColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "images/book-3.png",
                                          width: 55,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 7,
                                  width: size.width * .65,
                                  decoration: BoxDecoration(
                                    color: kProgressIndicator,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// UI de La Tarjeta de EXAMEN grande (debajo de las que están por temas) ///

  Container TarjetaDestacadaCentral(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
                image: DecorationImage(image: AssetImage("images/trial.png"),
                fit: BoxFit.cover)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "Temario actualizado convocatoria 2021",
                      style: TextStyle(
                        fontSize: 9,
                        color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "Simulacro Examen \nGuardia Civil 2021",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "Todos los Bloques",
                    style: TextStyle(color: kLightBlackColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 70.0),
                          //child: BookRating(score: 4.9),
                        ),
                        Expanded(
                          child: Text(
                            "Examen modelo de 100 preguntas tipo test de 90 minutos.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "images/book-3.png",
              width: size.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                text: "Simulacro",
                radious: 24,
                press: () {
                  return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: <Widget>[
                          Column(
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(
                                    MaterialPageRoute(/// NAVEGADOR AL TEST MEZCLANDO TEMAS (multi_test) PASANDO "CORREGIR EN DIRECTO" ///
                                      builder: (context) => multitest("examen","reveal"),
                                    ),
                                  );
                                },
                                padding: EdgeInsets.fromLTRB(0, 0, 55, 0),
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
                                    MaterialPageRoute( /// NAVEGADOR AL TEST MEZCLANDO TEMAS (multi_test) PASANDO "CORREGIR AL FINALIZAR" ///
                                      builder: (context) => multitest("examen","unreveal"),
                                    ),
                                  );
                                },
                                padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                                child: Text(
                                  'Corrección al finalizar',
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
            ),
          ),
        ],
      ),
    );
  }
}
