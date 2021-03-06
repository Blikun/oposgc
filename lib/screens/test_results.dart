import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:opos/screens/home_screen.dart';
import 'package:opos/screens/solve_screen.dart';
import 'package:opos/screens/solvesimple_screen.dart';
import 'package:opos/tests/multi_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

///PANTALLA DE RESULTADOS DE LOS TEST Y NAVEGADORES A CORRECCIONES DE PREGUNTAS DE LOS TESTS///

class testResults extends StatefulWidget {
  String name;
  int aciertos;
  int total;
  int nocontestadas;
  int fallos;
  int t1;
  int t2;//todo: hacer que solo el primer tema sea requerido y el resto opcionales
  int t3;
  var random_array;
  var eleccion;
  var guardia = Color.fromARGB(255, 0, 115, 80);

  
  testResults({Key key, @required this.name, this.aciertos, this.total, this.nocontestadas, this.fallos, this.t1, this.t2, this.t3, this.random_array, this.eleccion})
      : super(key: key);

  @override
  _testResultsState createState() => _testResultsState(name, aciertos, total, nocontestadas, fallos, t1, t2, t3, random_array, eleccion);
}


/// GRAFICO DE BARRAS INFERIOR//
class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HorizontalBarLabelChart(this.seriesList, {this.animate});

  factory HorizontalBarLabelChart.withSampleData() {
    return HorizontalBarLabelChart(
      _createSampleData(),
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      primaryMeasureAxis:
       charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      domainAxis:
       charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),

    );
  }

  /// valores grafico de barras inferior ///
  static List<charts.Series<ranking, String>> _createSampleData() {
    final data = [
       ranking('Derechos humanos', 15),
       ranking('Derecho penal', 13),
       ranking('Ingl??s', 3),
       ranking('D. Penal procesal', 21),
       ranking('Igualdad', 15),
       ranking('Consituci??n Espa??ola', 16),
       ranking('Derecho civil', 7),
       ranking('Europa', 10),
       ranking('Derecho policial', 18),
    ];

    return [
       charts.Series<ranking, String>(
          id: 'puntos',
          domainFn: (ranking puntos, _) => puntos.tema,
          measureFn: (ranking puntos, _) => puntos.puntos,
          data: data,

          colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,

          labelAccessorFn: (ranking puntos, _) =>
          '${puntos.tema}')
    ];
  }
}


class ranking {
  final String tema;
  final int puntos;
  ranking(this.tema, this.puntos);
}




///  GRAFICO CIRCULAR SUPERIOR ///

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  factory GaugeChart.fromValue(
      {@required double value,
      @required Color color,
      bool animate,
      double value2}) {
    return GaugeChart(
      _createDataFromValue(value, color, value2),
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 35,
        startAngle: 4 / 5 * pi,
        arcLength: 7 / 5 * pi,
      ),
    );
  }

  static List<charts.Series<GaugeSegment, String>> _createDataFromValue(
      double value, Color color, double value2) {
    double toShow = (value);
    double nc = (value2);
    final data = [
      GaugeSegment('Main', toShow, color),
      GaugeSegment('Rest', nc, Colors.red[800]),
      GaugeSegment('nc', 1 - nc - toShow, Colors.yellow[800]),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segmento,
        measureFn: (GaugeSegment segment, _) => segment.value,
        colorFn: (GaugeSegment segment, _) => segment.color,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (GaugeSegment segment, _) =>
            segment.segmento == 'Main' ? '${segment.value}' : null,
        data: data,
      )
    ];
  }
}

/// data type.
  class GaugeSegment {
  final String segmento;
  final double value;
  final charts.Color color;

  GaugeSegment(this.segmento, this.value, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

///gaugechart codigo <<

class _testResultsState extends State<testResults> {
  String message;
  String name;
  SharedPreferences prefs;

  void initState() {
    nocontestadas = total - (aciertos + fallos);
    puntuacionActual = (aciertos - ((fallos.toDouble() / 100) * 33)).toStringAsFixed(2);
    message = "Aciertos: $aciertos\nErrores:" +
        (fallos).toString() +
        "\nSin responder: $nocontestadas";
    super.initState();
    savescore(name);

  }

  /// GUARDAR RECORD DE PUNTOS POR TEMAS EN SHAREDPREFS ///
  savescore(String tema) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double puntuacionRecord = prefs.getDouble('$tema');
    print("tema: $tema");
    print("puntos: $puntuacionActual");

    if (puntuacionRecord == null || puntuacionRecord <= double.parse(puntuacionActual)){
      print("record superado");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('$tema', double.parse(puntuacionActual));
      print("guardado");
    }
    else{
      print("record no superado");
    };

  }

  /// NAVIGATOR LISTA DE RESPUESTAS ///
  solve(){
    if (name == "examen"){
      print("resolviendo multi");  
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => getsolve("penal",random_array, eleccion)
      ),
      );
    }
    else {
      print("resolviendo simple");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => getsolvesimple(name,random_array, eleccion)
      ),
      );
    }

  }

  int fallos;
  int total;
  int aciertos;
  int t1;
  int t2;
  int t3;
  int p;
  int nocontestadas;
  String puntuacionActual;
  var random_array;
  var eleccion;

  _testResultsState(this.name, this.aciertos, this.total, this.nocontestadas, this.fallos, this.t1, this.t2, this.t3, this.random_array, this.eleccion);

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var wid = screen.width;
    var hei = screen.height;
    total = random_array.length;


    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Material(
              child: Container(

                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, hei * 0.05, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container( /// Gauge Chart
                          decoration: BoxDecoration(

                            color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          width: wid * 0.92,
                          height: hei * 0.40,
                          child: Stack(children: <Widget>[
                            GaugeChart.fromValue(
                            value: ((aciertos).toDouble() / (total).toDouble()),
                            color: Colors.green,
                            value2: ((fallos).toDouble() / (total).toDouble())),
                            Center(
                              child: Column(children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, hei * 0.14, 0, 0),
                                    child: Text(
                                      puntuacionActual,
                                      style: TextStyle(fontSize: wid / 6,
                                ),
                              ),
                            ),

                                  Container( /// row iconos preguntas
                                     //color: Colors.blue,
                                     padding: EdgeInsets.fromLTRB(0, hei * 0.05, 0, 0),
                                     width: wid,
                                     child: Row(
                                        children: <Widget>[
                                           Expanded(flex: 3,
                                                 child: Padding(
                                                  padding: EdgeInsets.fromLTRB(wid * 0.20, 0, 0, 0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "images/v.png",
                                                          fit: BoxFit.contain,
                                                          scale: hei * 0.025,),
                                                        Text(
                                                           "$aciertos",
                                                            style: TextStyle(
                                                            fontSize: wid / 20.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                          Expanded(flex: 1,
                                              child: Column(
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/x.png",
                                                    fit: BoxFit.contain,
                                                    scale: hei * 0.025,),
                                                  Text(
                                                    "$fallos",
                                                    style: TextStyle(
                                                      fontSize: wid / 20.5,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              )
                                          ),
                                          Expanded(flex: 3,
                                            child: Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, wid * 0.20, 0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/nc.png",
                                                      fit: BoxFit.contain,
                                                      scale: hei * 0.025,),
                                                    Text(
                                                      "$nocontestadas",
                                                      style: TextStyle(
                                                        fontSize: wid / 20.5,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
                                     ),
                                  ),
                              ]),
                            ),
                          ]),
                        ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: hei * 0.01,
                        horizontal: wid * 0.04,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, hei * 0.05 , 0, 0),
                          child: Container(
                            width: wid,
                            height: hei * 0.32,
                            child: HorizontalBarLabelChart.withSampleData(),
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 33,
                                    color: Color(0xFFD3D3D3).withOpacity(.84),
                                  ),
                                ],
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            constraints: BoxConstraints(
                                minHeight: hei * 0.32,
                                minWidth: wid
                            ),
                          )
                        ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container( /// botones
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 115, 80)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      solve();
                    },
                    child: Text(
                      "Respuestas",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: "Quando",
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0,
                    ),
                    color: Colors.grey[300],
                    splashColor: Color.fromARGB(255, 0, 115, 80),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, wid * 0.15, 0),),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    },
                    child: Text(
                      "Continuar",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: "Quando",
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10.0,
                    ),
                    color: Colors.grey[300],
                    splashColor: Color.fromARGB(255, 0, 115, 80),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
