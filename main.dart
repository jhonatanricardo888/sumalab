import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Suma de 2 numeros')),
        body: const SumaNumeros(),
      ),
    );
  }
}

class SumaNumeros extends StatefulWidget {
  const SumaNumeros({super.key});

  @override
  State<SumaNumeros> createState() => _SumaNumerosState();
}

class _SumaNumerosState extends State<SumaNumeros> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String _resultado = '';

  void _sumar() {
    String texto1 = _num1Controller.text;
    String texto2 = _num2Controller.text;

    if (_esNumero(texto1) && _esNumero(texto2)) {
      double num1 = double.parse(texto1);
      double num2 = double.parse(texto2);
      double suma = num1 + num2;

      setState(() {
        _resultado = 'Resultado: $suma';
      });
    } else {
      setState(() {
        _resultado = 'Por favor ingresa solo numeros validos.';
      });
    }
  }

  bool _esNumero(String texto) {
    return double.tryParse(texto) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _num1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Numero 1'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _num2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Numero 2'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sumar,
            child: const Text('Sumar'),
          ),
          const SizedBox(height: 20),
          Text(
            _resultado,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
