import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opos/screens/test_results.dart';
import 'package:opos/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


var kText = Colors.grey[800];
var kTextCorrect = Colors.lightGreen[900];
var kTextWrong = Colors.red[900];
var kTextoff = Colors.grey[400];
var colortoshow = Colors.grey[800];
int marks;
int t1;
int t2;
int t3;
int fails;
int answered;
bool absorb;
int randomMax;
int min;
bool autocorrect;
var random_array;
var choicemade;
var btnmap;



class multitest extends StatelessWidget {

  String reveal;
  String name;
  multitest(this.name, this.reveal);

  String jsonfile;
  String jsonfile2;
  String jsonfile3;




  setasset() {
    Map<String, String> nameArray = {
      "derechos": "assets/derechoshumanos.json",
      "Examen": "assets/Examen.json",
      "penal": "assets/derechopenal.json",
      "ingles": "assets/ingles.json",
      "Constitución Española": "assets/constitucion.json",
    };

    if (name == "examen"){
      jsonfile = nameArray["ingles"];
      jsonfile2 = nameArray["derechos"];
      jsonfile3 = nameArray["penal"];
    }
    else {
      jsonfile = nameArray[name];
    }


    marks = 0;
    t1 = 0;
    t2 = 0;
    t3 = 0;
    fails = 0;
    answered = 0;
    absorb = false;
    randomMax = 15;
    min = 60;
    autocorrect = false;
    random_array = null;

    if (reveal == "reveal"){
      autocorrect = true;
    };

    if (reveal == "unreveal"){
      autocorrect = false;
    };

    choicemade = {
      for (var i = 0; i < 15; i++,)
        '$i': {
          "choice": "no",
        }
    };
    btnmap = {
      for (var i = 0; i < 100; i++,)
        '$i': {
          "a": Colors.grey[800],
          "b": Colors.grey[800],
          "c": Colors.grey[800],
          "d": Colors.grey[800],
          "s": false,

        },
      for (var u = 0; u < 100; u++,)
        '_$u': {
          "a": Colors.grey[800].withOpacity(0),
          "b": Colors.grey[800].withOpacity(0),
          "c": Colors.grey[800].withOpacity(0),
          "d": Colors.grey[800].withOpacity(0),
          "s": false,

        },
    };
  } // Obtener JSON segun <name>



  @override

  Widget build(BuildContext context) {
    setasset();
    debugPrint("builder multitest ");
    debugPrint("$name");
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;
      return FutureBuilder(

          future: DefaultAssetBundle.of(context).loadString(
              jsonfile, cache: true),
          builder: (context, snapshot) {
            List mydata = json.decode(snapshot.data.toString());

            if (mydata == null) {
              return Scaffold(
                body: Center(
                  child: Container(
                    height: 80,
                    width: wid * .6,
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
                                  "Cargando...",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Align(
                                  alignment:
                                  Alignment.bottomRight,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 7,
                    width: wid * .20,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 115, 80),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ]),
              ),
                  ),
                ));
            }

            return FutureBuilder(

              future: DefaultAssetBundle.of(context).loadString(
                  jsonfile2, cache: true),
              builder: (context, snapshot) {
                List mydata2 = json.decode(snapshot.data.toString());

                if (mydata2 == null) {
                  return Scaffold(
                    body: Center(
                      child: Container(
                        height: 80,
                        width: wid * .6,
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
                                                "Cargando...",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                Alignment.bottomRight,
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 7,
                                  width: wid * .3,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 0, 115, 80),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ),
                  );
                }
                else {
                  debugPrint("cargado");
                  debugPrint("mydata2 " + mydata2[0]["0"].toString());
                  return FutureBuilder(

                    future: DefaultAssetBundle.of(context).loadString(
                        jsonfile3, cache: true),
                    builder: (context, snapshot) {
                      List mydata3 = json.decode(snapshot.data.toString());

                      if (mydata3 == null) {
                        return Scaffold(
                          body: Center(
                            child: Container(
                              height: 80,
                              width: wid * .6,
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
                                                      "Cargando...",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                      Alignment.bottomRight,
                                                    ),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 7,
                                        width: wid * .50,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 0, 115, 80),
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        );
                      }
                      else {
                        debugPrint("cargado");
                        debugPrint("mydata3 " + mydata3[0]["0"].toString());
                        return testpage(
                            mydata: mydata, mydata2: mydata2, mydata3: mydata3, name: name,);
                      }
                    },
                  );
                }
              },
            );
          }
      );
    }
  } // Leer JSON Pantalla de carga > return testpage(mydata: mydata);
 // Leer y abrir JSON > mydata.

class testpage extends StatefulWidget {
  var mydata;
  var mydata2;
  var mydata3;
  String name;


  testpage({Key key, @required this.mydata, @required this.mydata2, @required this.mydata3, this.name}) : super(key: key);

  @override
  _testpageState createState() => _testpageState(mydata, mydata2, mydata3, name);
} //importar mydata a _testpageState

class _testpageState extends State<testpage> {
  String name;
  var mydata;
  var mydata2;
  var mydata3;
  var random_array;
  int j = 1;
  int count = 0;


  var guardia = Color.fromARGB(255, 0, 115, 80);

  _testpageState(this.mydata, this.mydata2, this.mydata3, this.name);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;

    void inicio() {

      if (min <= 0){
        Timer(Duration(milliseconds: 50), () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(
            builder: (context) =>
                testResults(
                    name: name,
                    aciertos: marks,
                    t1: t1,
                    t2: t2,
                    t3: t3,
                    total: randomMax,
                    fallos: fails,
                    random_array: random_array,
                    eleccion: choicemade,
                    ),
          ));
        });
      }
      if (random_array == null) {
        var distinctIds = [];
        var rand = new Random();

        for (int i = 0;;) {
          distinctIds.add(rand.nextInt(20) + 1);
          random_array = distinctIds.toSet().toList();
          if (random_array.length < randomMax) {
            continue;
          } else {
            break;
          }
        }
        print(random_array);
        setState(() {
          count = 15;
        });
      };
      //inicio
    }
    inicio();


    List<Widget> list = List.generate(count, (int index) => pagemake(mydata: mydata, mydata2: mydata2, mydata3: mydata3, index: index, random_array: random_array));

    void pausetest() async{


      var stringrandomarray = List<String>.from(random_array);

      print("$choicemade");
      print("$stringrandomarray");
      print("_____________");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var pause_choicemade = choicemade;
      var pause_randomarray = random_array;

      await prefs.setStringList('pause_randomarray', random_array);
      print("$pause_randomarray");

      await prefs.setString('pause_choicemade', choicemade);
      print("$pause_choicemade");

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(

        ),
      ));

    }

    void endtest(){

      var datos = null;

      for (int i = 0; i < count; i++,){

        print(choicemade[i.toString()]["choice"].toString());
        String option = choicemade[i.toString()]["choice"].toString();

        if (option == "no"){
          //skip
        }
        else {
          if (i <= 4){
            datos = mydata;
            if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()][option]) {
              t1 ++;
              marks++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["a"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["b"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["c"]) {
              fails++;
            } else if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["d"]) {
              fails++;
            }
          }
          else if (i > 4 && i <= 9){
            datos = mydata2;
            if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()][option]) {
              t2 ++;
              marks++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["a"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["b"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["c"]) {
              fails++;
            } else if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["d"]) {
              fails++;
            }
          }
          else if (i > 9 ){
            datos = mydata3;

            if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()][option]) {
              t3 ++;
              marks++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["a"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["b"]) {
              fails++;
            } else if
            (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["c"]) {
              fails++;
            } else if (datos[2][random_array[i].toString()] ==
                datos[1][random_array[i].toString()]["d"]) {
              fails++;
            }
          }
        }

      }

      print(marks);
      print(fails);
      print(t1);
      print(t2);
      print(t3);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(
        builder: (context) => testResults(
          name: name,
          aciertos: marks,
          t1: t1,
          t2: t2,
          t3: t3,
          total: randomMax,
          fallos: fails,
          random_array: random_array,
          eleccion: choicemade,
        ),
      ));

    }

    return WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(

                content: Text("¿Abandonar el examen?"),
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
          child: Container(
          decoration: BoxDecoration(
            color: guardia,
            image: DecorationImage(
              image: AssetImage("images/bg2.png"),

              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: <Widget>[
            Expanded(
              flex: 10, //barra top
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
                        child: IconButton(
                            alignment: Alignment.bottomLeft,
                            icon: Image.asset('images/back.png'),
                            onPressed: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content:
                                    Text("¿Abandonar el simluacro?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {

                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Volver',
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
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Salir',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Color.fromARGB(
                                                255, 0, 115, 80),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            }),
                      )),
                  Expanded(flex: 1, child: Container()),
                  Expanded(flex: 1, child: Container()),
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
                            "Corregir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                ),
              ),
                onPressed: () { endtest(); }),
          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                              border: Border.all(

                                color: guardia,
                                width: 3,
                              )),
                          child: Text(
                            min.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ),
                        CircularCountDownTimer(
                          key: UniqueKey(),
                          duration: 6,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          ringColor: Colors.grey[300],
                          fillColor: Colors.yellow[800],
                          strokeWidth: 4.0,
                          textStyle: TextStyle(
                              fontSize: 0.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                          isReverse: true,
                          onComplete: () {
                            setState(() {
                              min--;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: MaterialButton(
                            child: Text(
                              "Pausar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () { pausetest(); }),
                      ))
                ],
              ), //barra bot
            ),
          ]),
        ),
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

  pagemake(
      {Key key,
        @required this.mydata,
        @required this.mydata2,
        @required this.mydata3,
        @required this.index,
        @required this.random_array});

  @override
  State<StatefulWidget> createState() =>
      _pagemake(mydata: mydata, mydata2: mydata2, mydata3: mydata3, index: index, random_array: random_array);
}

class _pagemake extends State<pagemake> {
  final mydata;
  final mydata2;
  final mydata3;
  int index;
  var random_array;


  _pagemake(
      {Key key,
        @required this.mydata,
        @required this.mydata2,
        @required this.mydata3,
        @required this.index,
        @required this.random_array});

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

      choicemade[index.toString()]["choice"]=option;
      print(choicemade);



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
        btnmap["_$index"][option] = Colors.grey[800].withOpacity(0.04);

      });

    }
    void checkunreveal(String option) {

      choicemade[index.toString()]["choice"]=option;
      print(choicemade);


      if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()][option]) {
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;

        colortoshow = kText;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["a"]) {
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kText;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["b"]) {
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kText;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["c"]) {
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["a"] = kTextoff;
        btnmap["$index"]["d"] = kTextoff;
        colortoshow = kText;

      } else if (datos[2][random_array[index].toString()] ==
          datos[1][random_array[index].toString()]["d"]) {
        btnmap["$index"]["d"] = kTextoff;
        btnmap["$index"]["b"] = kTextoff;
        btnmap["$index"]["c"] = kTextoff;
        btnmap["$index"]["a"] = kTextoff;

        colortoshow = kText;
      }

      setState(() {

        btnmap["$index"][option] = colortoshow;
        btnmap["_$index"]["a"] = Colors.grey[800].withOpacity(0);
        btnmap["_$index"]["b"] = Colors.grey[800].withOpacity(0);
        btnmap["_$index"]["c"] = Colors.grey[800].withOpacity(0);
        btnmap["_$index"]["d"] = Colors.grey[800].withOpacity(0);
        btnmap["_$index"][option] = Colors.grey[800].withOpacity(0.04);

      });
    }

    void correct(String option){
      print(autocorrect);
      if(autocorrect == true){
        checkanswer(option);
      }
      else{
        checkunreveal(option);
      }
    };

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
            onPressed: () => correct(option),
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

