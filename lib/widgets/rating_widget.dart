import 'package:flutter/material.dart';
import 'package:opos/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
int step = 0;


///  ESTO SE ENCARGA DE ACTUALIZAR Y GUARDAR LOS PUNTOS DE LOS TEMAS QUE SE MUESTRAN EN HOME_SCREEN  ///
///  SE RECARGA SIEMPRE AL ENTRAR EN HOME_SCREEN  ///

class widget_rating extends StatefulWidget {
  String tema;

  widget_rating({Key key, @required this.tema,}) : super(key: key);
  @override
  _ratState createState() => _ratState(tema);
}

class _ratState extends State<widget_rating> {
  String tema;
  double rating;

  int step = 0; //variable de debug

  _ratState(this.tema);

  
  
  
  ///  BUSCA EL RATING SEGUN EL TEMA EN SHAREDPREFS Y LO DEVUELVE  ///
  
  getsharedprefscore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rating = prefs.getDouble('$tema');
    print("puntos para mostrar: $tema > $rating");
    double puntos = rating;
    if (rating==null){
      rating = 0;
    }
    setState(() {
      rating;
    });
    return puntos.toString();
  }

  ///   POR SI FALLA AL CONSEGUIR EL RATING PERO ES UN ARREGLO HORRIBLE Y NO SE SI FALLA  ///
  
  refresh() {
    print("getsharedprefscore() ejecutado $step veces");
    if (step <= 3){
      getsharedprefscore();
      step ++;
    }
  }
  
  
  
  /// ZONA DE LA UI QUE DIBUJA EL WIDGET
  @override
  Widget build(BuildContext context) {
    refresh(); //  LLAMA AL refresh() AL CONSTRUIR EL WIDGET
    print("tema $tema");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 7),
            blurRadius: 20,
            color: Color(0xFD3D3D3).withOpacity(.5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.assessment,
            color: kIconColor,
            size: 30,
          ),
          SizedBox(height: 5),
          Text(
            rating.toString(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
