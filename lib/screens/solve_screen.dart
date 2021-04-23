import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opos/screens/home_screen.dart';


/// PANTALLA DE CORRECCIONES DESPUES DE LOS TEST - ESTA MUESTRA LA CORRECCION DE MULTI_TEST ///

var kText = Colors.grey[800];
var kTextCorrect = Colors.lightGreen[900];
var kTextWrong = Colors.red[900];
var kTextoff = Colors.grey[300];
var colortoshow = Colors.grey[800];
bool absorb = true;
int randomMax = 15;
var btnmap;


class getsolve extends StatelessWidget {
  String name;
  var random_array;
  var choicemade;

  getsolve(this.name, this.random_array, this.choicemade);

  String jsonfile;
  String jsonfile2;
  String jsonfile3;


  setasset2() {
    Map<String, String> nameArray = {
      "derechos": "assets/derechoshumanos.json",
      "Examen": "assets/Examen.json",
      "penal": "assets/penal.json",
      "ingles": "assets/ingles.json",
      "Constitución Española": "assets/constitucion.json",
    };


    jsonfile = nameArray["ingles"];
    jsonfile2 = nameArray["derechos"];
    jsonfile3 = nameArray["penal"];

    btnmap = {
      for (var i = 0; i < 100; i++,)
        '$i': {
          "a": Colors.grey[800],
          "b": Colors.grey[800],
          "c": Colors.grey[800],
          "d": Colors.grey[800],
          "s": true
        },
      for (var u = 0; u < 100; u++,)
        '_$u': {
          "a": Colors.grey[800].withOpacity(0),
          "b": Colors.grey[800].withOpacity(0),
          "c": Colors.grey[800].withOpacity(0),
          "d": Colors.grey[800].withOpacity(0),
          "s": true
        },

    };

  } // Obtener JSON segun <name>

  @override
  Widget build(BuildContext context) {
    setasset2();
    debugPrint("builder... ");
    return FutureBuilder(

      future: DefaultAssetBundle.of(context).loadString(jsonfile, cache: true),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());

        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Cargando",
              ),
            ),
          );
        }
        else {
          debugPrint("else_1");
          debugPrint("mydata "+mydata[0]["0"].toString());

          return FutureBuilder(

            future: DefaultAssetBundle.of(context).loadString(jsonfile2, cache: true),
            builder: (context, snapshot) {
              List mydata2 = json.decode(snapshot.data.toString());

              if (mydata2 == null) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Cargando 2",
                    ),
                  ),
                );
              }
              else {
                debugPrint("else_2");
                debugPrint("mydata2 "+mydata2[0]["0"].toString());
                return FutureBuilder(

                  future: DefaultAssetBundle.of(context).loadString(jsonfile3, cache: true),
                  builder: (context, snapshot) {
                    List mydata3 = json.decode(snapshot.data.toString());

                    if (mydata3 == null) {
                      return Scaffold(
                        body: Center(
                          child: Text(
                            "Cargando 3",
                          ),
                        ),
                      );
                    }
                    else {
                      debugPrint("else_3");
                      debugPrint("mydata3 "+mydata3[0]["0"].toString());
                      return testpage2(mydata: mydata, mydata2: mydata2, mydata3: mydata3, random_array: random_array, choicemade: choicemade);
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  } // Leer JSON Pantalla de carga > return testpage2(mydata: mydata);
} // Leer y abrir JSON > mydata.

class testpage2 extends StatefulWidget {
  var mydata;
  var mydata2;
  var mydata3;
  var random_array;
  var choicemade;

  testpage2({Key key, @required this.mydata, @required this.mydata2, @required this.mydata3,@required this.random_array, @required this.choicemade}) : super(key: key);

  @override
  _testpage2State createState() => _testpage2State(mydata, mydata2, mydata3, random_array, choicemade);
} //importar mydata a _testpage2State

class _testpage2State extends State<testpage2> {
  var mydata;
  var mydata2;
  var mydata3;
  var random_array;
  var choicemade;
  int j = 1;
  int count = 0;

  var guardia = Color.fromARGB(255, 0, 115, 80);

  _testpage2State(this.mydata, this.mydata2, this.mydata3, this.random_array, this.choicemade);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;

    void inicio() {

      print(random_array);
      setState(() {
        count = 15;
      });

      //inicio
    }

    inicio();
    List<Widget> list = List.generate(count, (int index) => pagemake(mydata: mydata, mydata2: mydata2, mydata3: mydata3, index: index, random_array: random_array, choicemade: choicemade ));


    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(

              content: Text("¿Abandonar los resultados?"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Volver',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 0, 115, 80),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen(),),);
                  },
                  child: Text(
                    'Salir',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 0, 115, 80),
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ),

              ],
            ));
      },
      child: Scaffold(
        backgroundColor: guardia,
        body: Center(
          child: Material(
            color: guardia,
            child: Column(children: <Widget>[
              Expanded(
                flex: 10, //barra top
                child: Row(
                  children: <Widget>[
                  ],
                ),
              ),
              Expanded(
                flex: 100, //listiview central
                child: Container(
                  width: wid,
                  height: hei / 1.20,
                  child: PageView(
                    children: list,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: <Widget>[

                    Expanded(
                        flex: 1,
                        child: Container(
                          child: MaterialButton(
                              child: Text(
                                "Continuar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomeScreen(),),);
                              }),
                        ))
                  ],
                ), //barra bot
              ),
            ]),
          ),
        ),
      ),
    );
    //  PRINCIPAL UI
  }
}

class pagemake extends StatefulWidget {
  final mydata;
  final mydata2;
  final mydata3;
  int index;
  var random_array;
  var choicemade;

  pagemake(
      {Key key,
        @required this.mydata,
        @required this.mydata2,
        @required this.mydata3,
        @required this.index,
        @required this.random_array,
        @required this.choicemade});

  @override
  State<StatefulWidget> createState() =>
      _pagemake(mydata: mydata, mydata2: mydata2, mydata3: mydata3, index: index, random_array: random_array, choicemade: choicemade);
}

class _pagemake extends State<pagemake> {
  final mydata;
  final mydata2;
  final mydata3;
  int index;
  var choicemade;
  var random_array;

  _pagemake(
      {Key key,
        @required this.mydata,
        @required this.mydata2,
        @required this.mydata3,
        @required this.index,
        @required this.random_array,
        @required this.choicemade});

  @override
  Widget space(int flex) {
    return Expanded(flex: flex, child: Container());
  } //espaciador



  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;
    var datos;

    if (index <= 4){
      datos = mydata;
    }
    else if (index > 4 && index <= 9){
      datos = mydata2;
    }
    else if (index > 9 ){
      datos = mydata3;
    }

    void checkanswer(String option) {
      if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()][option]) {
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;

        colortoshow = kTextCorrect;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["a"]) {
        btnmap["$index"]["a"] = kTextCorrect;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kTextWrong;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["b"]) {
        btnmap["$index"]["b"] = kTextCorrect;
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kTextWrong;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["c"]) {
        btnmap["$index"]["c"] = kTextCorrect;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kTextWrong;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["d"]) {
        btnmap["$index"]["d"] = kTextCorrect;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["a"] = kTextoff;

        colortoshow = kTextWrong;
      }

      setState(() {

        btnmap["$index"][option] = colortoshow;
        btnmap["$index"]["s"] = true;
        btnmap["_$index"][option] = Colors.grey[800].withOpacity(0.12);

      });

      // Timer(Duration(seconds: 2), nextquestion);
    }

    void resolve(choicemade){
      String chosen;
      chosen = choicemade[index.toString()]["choice"];
      print(choicemade[index.toString()]["choice"]);
      checkanswer(chosen);
    };

    resolve(choicemade);

    Widget choicetab(String option) {
      var screen = MediaQuery.of(context).size;
      var wid = screen.width;
      var hei = screen.height;


      return AbsorbPointer(
        absorbing: btnmap["$index"]["s"],
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: hei / 20,
          child: Container(   // botones
            decoration: BoxDecoration(
                color: btnmap["_$index"][option],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: wid,
            constraints: BoxConstraints(
                minHeight: 55
            ),

            alignment: Alignment.centerLeft,
            child: Text(
              option + ")   " + datos[1][random_array[index].toString()][option],
              style: TextStyle(
                  fontSize: 15.0,
                  color: btnmap["$index"][option]
              ),
              textAlign: TextAlign.start,
            ),
            padding: EdgeInsets.fromLTRB(12, 0, 5, 0),

          ),
          onPressed: () => checkanswer(option),
        ),
      );
    } //botones de respuestas


    return Padding(

        padding: EdgeInsets.all(0),
        child: Container(
          width: wid,
          height: hei / 1.20,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.elliptical(800, 100))),
          child: Column(
            children: <Widget>[
              space(3),
              Expanded(
                  flex: 4, // top pregunta
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Pregunta " + (index + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                    width: wid / 1.05,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 18, // pregunta
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12, 5, 10, 0),
                    width: wid / 1.05,
                    height: hei,
                    color: Colors.grey[300],
                    child: Text(
                      datos[0][random_array[index].toString()].toString(),
                      //json pregunta
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 4, // bot pregunta
                  child: Container(
                    width: wid / 1.05,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                "images/libro.png",
                                color: Colors.grey[600],
                                height: 22,
                              ),
                              Text(
                                " " + datos[0]["0"].toString(),
                                //json nombre tema
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              space(2),
              Expanded(
                  flex: 50, //opciones (choicetab)
                  child: Container(
                    width: wid / 1.00,
                    height: hei,
                    child: ListView(
                      children: <Widget>[
                        choicetab("a"),
                        Divider(
                          thickness: 1.5,
                        ),
                        choicetab("b"),
                        Divider(
                          thickness: 1.5,
                        ),
                        choicetab("c"),
                        Divider(
                          thickness: 1.5,
                        ),
                        choicetab("d"),
                      ],
                    ),
                  )),
              space(3)
            ],
          ),
        ));
  }
}
