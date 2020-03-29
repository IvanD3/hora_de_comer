import 'dart:math';

import 'package:flutter/material.dart';
import 'Capitulo.dart';
import 'package:gsheets/gsheets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

//Aquí iría la credencial de Google Sheets
const _credentials = r'''

''';

const _spreadsheetId = '1gQ0jNI9jXdjW2Jq52OtFBDAaqhZyg9pdBLHHgYFB-hQ';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Color(0xFF05A5EF),
        scaffoldBackgroundColor: Colors.white,
        secondaryHeaderColor: Colors.green,
        buttonColor: Color(0xFFFFD90F),
        textSelectionColor: Colors.black
      ),
      darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          //backgroundColor: Color(0xFF121F25),
          backgroundColor: Color(0xFF015396),
          scaffoldBackgroundColor: Color(0xFF121F25),
          secondaryHeaderColor: Colors.lightGreen,
          buttonColor: Color(0xAAFFD90F),
          textSelectionColor: Colors.white70
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _cargarURLCapitulos()async{
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = await ss.worksheetByTitle('capitulazos');
    //List<String> direcciones = await sheet.values.column(3);
    var elementos = await sheet.values.value(column: 5, row: 1);
    int valor = int.parse(elementos);
    Random rng = new Random();
    int fila = rng.nextInt(valor) + 1;
    print("Lanzando episodio número:");
    print(fila);
    String URL = await sheet.values.value(column: 3, row: fila);
    _launchURL(URL);
  }

  //Método para abrir el enlace
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //listaEpisodios.add(new Capitulo(1,1,'https://www.disneyplus.com/es-es/video/79529cd0-f1cf-4eec-8b1d-ea1e1b76043b'));
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 200,
              height: 200,
              buttonColor:  Theme.of(context).buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black)
              ),
              child: RaisedButton(
                onPressed: _cargarURLCapitulos,
                child: Icon(
                  Icons.play_arrow,
                  size: 100,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton(
       backgroundColor: Theme.of(context).buttonColor,
       shape: RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(18.0),
           side: BorderSide(color: Colors.black)
       ),
       child: Icon(
           Icons.info_outline,
         color: Theme.of(context).backgroundColor,
       ),
       onPressed: (){
         _informacion(context);
       },
     ),  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _informacion(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Acerca de la aplicación",style:TextStyle(color: Theme.of(context).textSelectionColor),),
            content: Text("Esta aplicación escoge un capítulo aleatorio de los Simpsons y lo abre en la aplicación de Disney+.\n\nEsta aplicación no posee contenido sin licencia ni afiliación o relación con Disney, únicamente enlaza a contenidos de la plataforma oficial de streaming.\n\nFinalmente, es necesaria una suscripción a Disney+ para acceder a los episodios.\n\nEsta aplicación es gratuita y sin anuncios, aunque puedes invitarme a un café pulsando en este botón :)",style:TextStyle(color: Theme.of(context).textSelectionColor),),
            shape:  RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.black)
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: <Widget>[
              ButtonTheme(
                buttonColor:  Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)
                ),
                child: RaisedButton(
                  onPressed: (){_launchURL("https://www.paypal.me/IvanD3/1");},
                  child:
                    Icon(
                      Icons.free_breakfast,
                      color: Theme.of(context).backgroundColor,
                    ),
                ),
              ),
            ],
          );
        });
  }
}

