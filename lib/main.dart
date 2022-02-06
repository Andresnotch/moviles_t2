import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            iconColor: Colors.green, fillColor: Colors.green),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.green,
            selectionColor: Colors.green,
            selectionHandleColor: Colors.green),
        appBarTheme: const AppBarTheme(color: Colors.green),
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _generoFemenino = true;
  final TextEditingController _mController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final String _idealMujeres = '''
    Niveles mujeres

    Desnutrición: 16
    Bajo Peso: 17 - 20
    Normal: 21 - 24
    Sobrepeso: 25 - 29
    Obesidad: 30 - 34
    Obesidad Marcada: 35 - 39
    Obesidad Mórbida: 40+
  ''';
  final String _idealHombres = '''
    Niveles hombres

    Desnutrición: 17
    Bajo Peso: 18 - 20
    Normal: 21 - 25
    Sobrepeso: 26 - 30
    Obesidad: 31 - 35
    Obesidad Marcada: 36 - 40
    Obesidad Mórbida: 40+
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _mController.text = '';
                _kgController.text = '';
                _generoFemenino = true;
                setState(() {});
              })
        ],
        title: const Text('Calcular IMC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
            child: Text('Ingrese sus datos para calcular el IMC'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.female,
                      color: _generoFemenino ? Colors.pink : Colors.grey),
                  onPressed: () {
                    _generoFemenino = !_generoFemenino;
                    setState(() {});
                  }),
              IconButton(
                  icon: Icon(Icons.male,
                      color: _generoFemenino ? Colors.grey : Colors.blue),
                  onPressed: () {
                    _generoFemenino = !_generoFemenino;
                    setState(() {});
                  }),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(6),
            child: TextField(
              controller: _mController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresar altura (Metros)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 3)),
                  icon: Icon(
                    Icons.square_foot,
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            child: TextField(
              controller: _kgController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingresar peso (KG)',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 3)),
                  icon: Icon(Icons.monitor_weight)),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_kgController.text.isNotEmpty &&
                  _mController.text.isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Tu IMC: ' +
                        (double.parse(_kgController.text) /
                                pow(double.parse(_mController.text), 2))
                            .toStringAsFixed(2)),
                    content:
                        Text(_generoFemenino ? _idealMujeres : _idealHombres),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                    title: Text('Error'),
                    content: Text('No has llenado todos los datos'),
                  ),
                );
              }
            },
            child: const Text('Calcular'),
          ),
        ],
      ),
    );
  }
}
