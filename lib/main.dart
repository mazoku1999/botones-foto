import 'package:flutter/material.dart';
import 'package:android_physical_buttons/android_physical_buttons.dart'
    as physical_buttons;
import 'dart:async';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _State();
}

class _State extends State<App> {
  int _clickCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    physical_buttons.AndroidPhysicalButtons.listen((physical_buttons.Key key) {
      if (key == physical_buttons.Key.power) {
        _clickCount++;

        // Cancelar el timer anterior si existe
        _timer?.cancel();

        // Crear nuevo timer
        _timer = Timer(const Duration(milliseconds: 500), () {
          if (_clickCount == 2) {
            print('hola mundo');
          }
          _clickCount = 0; // Reiniciar contador
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Android Physical Buttons'))));
  }
}
