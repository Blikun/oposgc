import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opos/screens/test_results.dart';
import 'package:opos/screens/home_screen.dart';

import '../constants.dart';

int puntos_tema_1=0;
int t2; //inutil
int t3; //inutil
int tiempo=60;
int aciertos=0;
int errores=0;
int contestadas=0;   //todo: implementar el contador, el problema es que es un setsate de otro widget, con un callback? hay que ver eso.
int total_preguntas=15;
bool boton_bloqueado = false;
var random_array = null;
bool revelar_correcta = false;
var respuestas_usuario;
var opciones_respuesta;

class monotest extends StatelessWidget {
  var reveal;
  var id;
  String name;
  var multiple;

  monotest(this.name,  this.id, this.reveal, this.multiple);

  String jsonfile;
  String jsonfile2;
  String jsonfile3;
  var tema1;
  var tema2;
  var tema3;

  setasset() {
    Map<int,String> temas ={
      1:"assets/derechoshumanos.json",
      2:"assets/igualdad.json",
      3:"assets/prevencionriesgoslaborales.json",
      4:"assets/constitucion.json",
      5:"assets/defensorpueblo.json",
      6:"assets/tratadounioneuropea.json",
      7:"assets/funcionamientounioneuropea.json",
      8:"assets/institucionesinternacionales.json",
      9:"assets/derechocivil.json",
      10:"assets/derechopenal.json",
      11:"assets/leyenjuiciamientocriminal.json",
      12:"assets/leyorganicahabeascorpus.json",
      13:"assets/leyorganicapoderjudicial.json",
      14:"assets/policiajudicial.json",
      15:"assets/ley392015.json",
      16:"assets/ley402015.json"
    };
    jsonfile = temas[1];
    jsonfile2 = temas[2];
    jsonfile3 = temas[3];
  }

  resetBotones(){
    opciones_respuesta = {  // MAP CON LOS COLORES DE CADA BOTON DE RESPUESTA
      for (var i = 0; i < 100; i++,)  // el numero que se crea es 100
        '$i': {
          "a": color_standard,
          "b": color_standard,
          "c": color_standard,
          "d": color_standard,
          "s": false,  //si el boton esta desactivado es true
        },
      for (var u = 0; u < 100; u++,)
        '_$u': {
          "a": color_standard.withOpacity(0),
          "b": color_standard.withOpacity(0),
          "c": color_standard.withOpacity(0),
          "d": color_standard.withOpacity(0),
          "s": false,  //si el boton esta desactivado es true
        },
    };
  }
  nuevoTest(){
    tiempo = 60; //reset tiempo
    aciertos=0; //reset puntos
    errores=0; //reset puntos
    contestadas=0; //reset puntos
    var preguntasMax = total_preguntas;

    if(multiple==true){
      preguntasMax = 20;
    }else{
      preguntasMax = total_preguntas;
    };
    respuestas_usuario = {
      for (var i = 0; i < preguntasMax; i++,)
        '$i': {  // CREAR ARRAY PARA ALMACENAR LAS RESPUESTAS Y MARCAR TODAS "NO CONTESTADO"
          "choice": "no",
        }
    };
  }

  @override
  Widget build(BuildContext context) {
    revelar_correcta = reveal;
    setasset(); //selector de json
    resetBotones(); //reset necesario para re-pintar en blanco los botones de respuesta
    nuevoTest();  //resets necesarios para borrar los ultimos resultados y el tiempo


    Future cargar(preguntasJson) async{
      String jsonString = await DefaultAssetBundle.of(context).loadString(preguntasJson, cache: true);
      tema1 = json.decode(jsonString);
      print(tema1);
      return tema1;
    };

    Future cargaMultiple() async{
      String jsonString = await DefaultAssetBundle.of(context).loadString(jsonfile, cache: true);
      tema1 = json.decode(jsonString);
      print(tema1);
      String jsonString2 = await DefaultAssetBundle.of(context).loadString(jsonfile2, cache: true);
      tema2 = json.decode(jsonString2);
      print(tema2);
      String jsonString3 = await DefaultAssetBundle.of(context).loadString(jsonfile3, cache: true);
      tema3 = json.decode(jsonString3);
      print(tema3);
      return true;
    };


    if(multiple == false){
      return FutureBuilder(
        future:
        cargar(jsonfile),
        builder: (context, snapshot) {
          if (tema1 == null) {
            return Scaffold(); //PANTALLA DE CARGA MIENTRAS NO HAY DATOS
          } else {
            print("test simple");
            return monotestpage(mydata: tema1, name: name, multiple: multiple); //ME VOY AL TEST CON LOS DATOS (name no importa)
          }
        },
      );
    }else{
      return FutureBuilder(
        future:
        cargaMultiple(),
        builder: (context, snapshot) {
          if (tema3 == null) {
            return Scaffold(); //PANTALLA DE CARGA MIENTRAS NO HAY DATOS
          } else {
            print("test multiple"); ///todo: hacer que genere 1 json con todo el test dentro y se acabó no jodas
            return monotestpage(mydata: tema1, mydata2: tema2, name: name, multiple: multiple); //ME VOY AL TEST CON LOS DATOS (name no importa)
          }
        },
      );
    };
  }
}

class monotestpage extends StatefulWidget {
  var multiple;
  var mydata;
  var mydata2;
  String name;
  monotestpage({Key key, this.multiple, this.mydata, this.name, this.mydata2,}) : super(key: key);
  @override
  _monotestpageState createState() => _monotestpageState(multiple, name, mydata, mydata2,);
} 

class _monotestpageState extends State<monotestpage> {
  var multiple;
  var mydata;
  var mydata2;
  var name;
  var random_array;
  int j = 1;
  int count = 0;

  _monotestpageState(this.multiple,  this.name, this.mydata, this.mydata2);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;

    void inicio() {///genera numeros aleatorios no repetidos en un rango para elegir las preguntas que va a tener el test.

      var preguntasMax = total_preguntas;
      if(multiple==true){
        preguntasMax = 20;
      };


      if (random_array == null) {

        var num_distintos = [];
        var random = new Random();
        for (int i = 0;;) {
          num_distintos.add(random.nextInt(20) + 1); //todo: aqui cojo ese numero 20 por que solo hay 20 preguntas hechas aun en los temas
          random_array = num_distintos.toSet().toList();
          if (random_array.length < preguntasMax) {
            continue;
          } else {
            break;
          }
        }
        print(random_array);
        setState(() {
          count = preguntasMax;
        }
        );
      }

      if (tiempo <= 0){
        Timer(Duration(milliseconds: 50), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => testResults(name: name, aciertos: aciertos, total: total_preguntas,
                fallos: errores, t1: 0, t2: 0, t3: 0, random_array: random_array, eleccion: respuestas_usuario,
              ),
            ),
                (route) => false,
          );
        });
      }
    }
    
    inicio();

    /// GENERAR PUNTOS SEGUN LAS RESPUESTAS FINALES AL TERMINAR EL TEST
    void finTest(){
      var datos = null;
      for (int i = 0; i < count; i++,){

        var respuesta_seleccionada = respuestas_usuario[i.toString()]["choice"].toString();

        if (respuesta_seleccionada == "no"){
          //skip: pregunta no contestada
        }
        else {

          if(multiple==false){datos = mydata;}
          else{
            if(i <= 3){
              datos=mydata;
            }
            if(i > 3){
              datos=mydata2;
            }
          };


            var respuesta_correcta = datos[2][random_array[i].toString()];
            var respuestas = datos[1][random_array[i].toString()];

            if (respuesta_correcta == respuestas[respuesta_seleccionada]) {
              puntos_tema_1++;
              aciertos++;
            } else if
            (respuesta_correcta == respuestas["a"]) {
              errores++;
            } else if
            (respuesta_correcta == respuestas["b"]) {
              errores++;
            } else if
            (respuesta_correcta == respuestas["c"]) {
              errores++;
            } else if (respuesta_correcta == respuestas["d"]) {
              errores++;
            }
          }}

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => testResults(
            name: name,
            aciertos: aciertos,
            total: total_preguntas,
            fallos: errores,
            t1: 0,
            t2: 0,
            t3: 0,
            random_array: random_array,
            eleccion: respuestas_usuario,
          ),
        ), /// IR A RESULTADOS
            (route) => false,
      );
    }

    List<Widget> list = List.generate(count, (int index) => pagemake(mydata: mydata, mydata2: mydata2, index: index, random_array: random_array, multiple: multiple));

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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ),
                            (route) => false,
                      );
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
              )
          );
        },
    child: Scaffold(
      //backgroundColor: guardia,
      body: Center(
        child: Material(
         // color: guardia,
          child: Container(
            decoration: BoxDecoration(
              color: kguardiacivil,
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
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => HomeScreen(),
                                            ),
                                                (route) => false,
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
                      alignment: Alignment.center,
                      child: Text(
                        contestadas.toString() + "/100",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
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
                                color: kguardiacivil,
                                width: 3,
                              )),
                          child: Text(
                            tiempo.toString(),
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
                              tiempo--;
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
                              "Corregir",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () { finTest(); }),
                      ))
                ],
              ), //barra bot
            ),
          ]),
        ),
      ),
      )
    ),
    );/// CONFIRMACION POR SI PULSAS ATRÁS EN EL MOVIL.
  }
}

class pagemake extends StatefulWidget {
  final mydata;
  final mydata2;
  int index;
  var random_array;
  var multiple;

  pagemake(
      {Key key,
        @required this.multiple,
        @required this.mydata,
        @required this.mydata2,
        @required this.index,
        @required this.random_array});

  @override
  State<StatefulWidget> createState() =>
      _pagemake(multiple: multiple, mydata: mydata, mydata2: mydata2, index: index, random_array: random_array);
}

class _pagemake extends State<pagemake> {
  final mydata;
  final mydata2;
  int index;
  var random_array;
  var multiple;

  _pagemake(
      {Key key,
        @required this.mydata,
        this.mydata2,
        @required this.index,
        @required this.random_array,
        @required this.multiple});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;
    var datos;

    if (multiple == false){
      datos = mydata;
    }else{
      if(index <= 3){
        datos = mydata;
      }else{
        datos = mydata2;
      }
    }


    /// CORRECCION VISUAL DE LOS BOTONES DE RESPUESTA  todo: sacar estas funciones de aqui y que el test mono y multi los usen
    void corregirMostrar(String respuesta_seleccionada) {
      
      respuestas_usuario[index.toString()]["choice"] = respuesta_seleccionada;// añade la respuesta elegida a la lista de respuestas global
      var respuesta_correcta = datos[2][random_array[index].toString()];
      var respuestas = datos[1][random_array[index].toString()];

      //marca en gris las respuestas previo a la correccion
      opciones_respuesta["$index"]["a"] = color_desactivado;
      opciones_respuesta["$index"]["b"] = color_desactivado;
      opciones_respuesta["$index"]["c"] = color_desactivado;
      opciones_respuesta["$index"]["d"] = color_desactivado;

      //comprueba si hay acierto o busca cual hubiera sido la correcta y la repinta
      if (respuesta_correcta == respuestas[respuesta_seleccionada]) {
        color_respuesta_elegida = color_correcto;
      } else if (respuesta_correcta == respuestas["a"]) {
        opciones_respuesta["$index"]["a"] = color_correcto;
        color_respuesta_elegida = color_error;
      } else if (respuesta_correcta == respuestas["b"]) {
        opciones_respuesta["$index"]["b"] = color_correcto;
        color_respuesta_elegida = color_error;
      } else if (respuesta_correcta == respuestas["c"]) {
        opciones_respuesta["$index"]["c"] = color_correcto;
        color_respuesta_elegida = color_error;
      } else if (respuesta_correcta == respuestas["d"]) {
        opciones_respuesta["$index"]["d"] = color_correcto;
        color_respuesta_elegida = color_error;
      }

      setState(() {
        opciones_respuesta["$index"][respuesta_seleccionada] = color_respuesta_elegida;
        opciones_respuesta["$index"]["s"] = true;  //controla que la serie de botones sea pulsable o no.
        opciones_respuesta["_$index"][respuesta_seleccionada] = Colors.grey[800].withOpacity(0.04);
      });
    }
    /// CORRECCION OCULTA DE LOS BOTONES DE RESPUESTA  todo: sacar estas funciones de aqui y que el test mono y multi los usen
    void corregirOcultar(String respuesta_seleccionada) {

      respuestas_usuario[index.toString()]["choice"] = respuesta_seleccionada;
      color_respuesta_elegida = color_standard;
      
      opciones_respuesta["$index"]["a"] = color_desactivado;
      opciones_respuesta["$index"]["b"] = color_desactivado;
      opciones_respuesta["$index"]["c"] = color_desactivado;
      opciones_respuesta["$index"]["d"] = color_desactivado;

      setState(() {
        opciones_respuesta["$index"][respuesta_seleccionada] = color_respuesta_elegida;
        opciones_respuesta["_$index"]["a"] = Colors.grey[800].withOpacity(0);
        opciones_respuesta["_$index"]["b"] = Colors.grey[800].withOpacity(0);
        opciones_respuesta["_$index"]["c"] = Colors.grey[800].withOpacity(0);
        opciones_respuesta["_$index"]["d"] = Colors.grey[800].withOpacity(0);
        opciones_respuesta["_$index"][respuesta_seleccionada] = Colors.grey[800].withOpacity(0.04);
      });
    }

    void corregir(String respuesta_seleccionada){
      if (revelar_correcta == true) {corregirMostrar(respuesta_seleccionada);}
      else {corregirOcultar(respuesta_seleccionada); }
    };

      ///WIDGET DE BOTON DE RESPUESTA
      Widget botonRespuesta(String opcion) {
        var screen = MediaQuery.of(context).size;
        var wid = screen.width;
        var hei = screen.height;
        return AbsorbPointer(
          absorbing: opciones_respuesta["$index"]["s"], // boton activo: true/false
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: hei / 20,
            child: Container(  
              decoration: BoxDecoration(
                  color: opciones_respuesta["_$index"][opcion],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: wid,
              constraints: BoxConstraints(
                  minHeight: 55
              ),

              alignment: Alignment.centerLeft,
              child: Text(
                opcion + ")   " + datos[1][random_array[index].toString()][opcion],
                style: TextStyle(
                    fontSize: 15.0,
                    color: opciones_respuesta["$index"][opcion]
                ),
                textAlign: TextAlign.start,
              ),
              padding: EdgeInsets.fromLTRB(12, 0, 5, 0),
            ),
            onPressed: () => corregir(opcion),
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
                        datos[0][random_array[index].toString()].toString(), //json pregunta
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
                                  " " + datos[0]["0"].toString(), //json nombre tema
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
                    flex: 50, //botones de respuesta
                    child: Container(
                      width: wid / 1.00,
                      height: hei,
                      child: ListView(
                        children: <Widget>[
                          botonRespuesta("a"),
                          Divider(
                            thickness: 1.5,
                          ),
                          botonRespuesta("b"),
                          Divider(
                            thickness: 1.5,
                          ),
                          botonRespuesta("c"),
                          Divider(
                            thickness: 1.5,
                          ),
                          botonRespuesta("d"),
                        ],
                      ),
                    )),
                space(3)
              ],
            ),
          ));
  }
}

