import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Por favor, informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Por favor, informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person, size: 120.0, color: Colors.deepPurple),
              TextFormField(
                cursorColor: Colors.deepPurple,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90)),
                  labelText: "Peso (Kg)",
                  labelStyle: const TextStyle(color: Colors.deepPurple),
                ),
                style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso!";
                  }
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                cursorColor: Colors.deepPurple,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90)),
                  labelText: "Altura (m)",
                  labelStyle: const TextStyle(color: Colors.deepPurple),
                ),
                style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
                controller: heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 110, top: 20, bottom: 5, right: 110),
                child: Container(
                  color: Colors.deepPurple,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.deepPurple, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
