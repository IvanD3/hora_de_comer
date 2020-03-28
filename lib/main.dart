import 'dart:math';

import 'package:flutter/material.dart';
import 'Capitulo.dart';
import 'package:gsheets/gsheets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "hdc-ls",
  "private_key_id": "76e349d6a2a599d903d483e24825343790ff568b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDKtz2QIfGLnytN\n28SIyW+QcaTW4id0Yh+TorZZsFRa6sPmTa9XpkvYL06HQZfSLi/lRqVJE2hkY/fP\nMVXDJrG3nK6jz2wUI6OQPv5kVbZZwXrrcAK7boq8uFcTXznpZ3mnWlxs+u6SR6YQ\n25yDw2s0qFJ731sksj8t7PHQ6OSVWx2QDvWZ5ovCzb+7dZOzOSNUdmz5KBVS4gjj\nHrLhh/0HRrWP8seimMikXgk7goI9ArFl00VwJFNnoX9tnzWkNhnkqO7tBQHN3dnq\nU4sjXa5a5AJXD1kLbgTGdg4jqwpJZOcRqO3ZbPXO9LzoFWOqj5ErjzOmVA3o1JdI\nWs5KNkZXAgMBAAECggEAG02g6hfYS8DteTgfeXkAIMldtV+Shtdsf1sMCnp4ciJq\nrktKUZjhYEXG4urPwwxbgRsJyhTmG5dnWi2/6l/80ck1sHSQjwnZzuTdKLButhoc\nLzfP9mTGJPMDL2XFDA3W0daW2krV9TfXQzABHbIlb1s4eNy1jvS/E7V1QHkNyJvW\nkqSkQADlRizSqksp2mIo/Yo5sb43q1HlR764mAl7VL3RbMSCwD1lWBmIPOFwfpwB\nQ1vQDqts3HOrh08KmGAS6e4ZZ8T5AP5j29A27RDXdWj0ZanRf7vLzYVEEhPoU7Y3\nThFpQZim+aYp6yI6LVi203rjz5WsjtvrvudZkkA7CQKBgQD0sY88BUdCzNiJ75OV\nxfyu1OOoBKcVSZiyshCvJj87p5ieDDOTPHQBetH41cRGDenF1ZAAon/IwkZ4azzV\nREmBSXE7O861wP90i7hf056WPgfzAJUaj3i0QWGrEwpYnqYEZfQ0VxIQiAvIiLlQ\n0QNCFacLabDnZ8yKgLcI9WDobQKBgQDUFSHgtuX0Y5x/dTrg6K62ObOQUUibwtMM\npzVjrU2WiAvhFwyuy1srLPGl4/CZviY8WjNzXcwdI2HuLyz8mJMWeXzrd3y/07HL\nmG8Ql7T8ft/HGua8TrxW1USZm4wti5TyusQk7p81I7oDVDCPzW2tignvnIDsiu+r\ntyny7xm3UwKBgCE9qc6mjOq3N0dtw2faUJxTkWW21BfhOpwz8m5IzNhGyUXXNH5w\n/PVigPnD2HkH1NUqUPi1GpTkR3x+XPI/55hnqLk6Q7ePM2Tawj5KWkXgwWWyk47b\nJLOgGiuKV6J4UudQDl+54Ftcj/U7Famz6zRkCqBTSFP3VuMN30+ZPgP1AoGAWfJY\neui3IG46ymfav9aPeqOAP33p0H3RarVj1FGE7Ynnl+BhtaRzlx0po5THzzyxFLmg\nxpYKYnVGLHF/n+XJxCdkTq1PkD/lURbmS+A7lzbsC5KiN00hXaZ3wLoSuqJPWp7R\nX2SAy1XKp2zGZ8bVdFtuGVyD5U6LlYVKWkkD3BcCgYBQnwTe4P3PjOTgZ3cwDkrJ\n2bGoWjJtpr7oJ/gPCRhcTLucUK0Er0tL0goNQUV8ghdzM35Awgp9TOzEklMVVVhm\npm0Rf5+Hhlmsla/vrPUCxyvPFsbyLDdUsrlwUR8fo85MsMvLCoLCxwCo/iTqaEWM\n9P5d6QksmIaIWLed5Yk4hA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@hdc-ls.iam.gserviceaccount.com",
  "client_id": "102683251242105420331",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40hdc-ls.iam.gserviceaccount.com"
}
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> enlacesCapitulos = new List<String>();
  //List<Capitulo> listaEpisodios = new List<Capitulo>();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  void _peticionHojaCalculo() async{
    print("Vamos al putiferio");
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = await ss.worksheetByTitle('capitulazos');
    //await sheet.values.insertValue('PUTAAA', column: 5, row: 2);
    var celdas = await sheet.cells.findByValue("1");
    List<String> direcciones = await sheet.values.column(3);
    print(direcciones);
    print(direcciones.runtimeType);
    print(direcciones[0]);
    print(direcciones[0].runtimeType);
  }

  _launchURL(url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<List<String>> _cargarURLCapitulos()async{
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = await ss.worksheetByTitle('capitulazos');
    List<String> direcciones = await sheet.values.column(3);
    Random rng = new Random();
    print(rng.nextInt(direcciones.length-1));
    _launchURL(direcciones[rng.nextInt(direcciones.length-1)]);
    return direcciones;
  }
  @override
  Widget build(BuildContext context) {

    //listaEpisodios.add(new Capitulo(1,1,'https://www.disneyplus.com/es-es/video/79529cd0-f1cf-4eec-8b1d-ea1e1b76043b'));
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Putaa"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cargarURLCapitulos,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

