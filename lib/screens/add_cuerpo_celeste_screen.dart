import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planets/db/database_helper.dart';
import 'dart:io';
import 'dart:async';

import 'package:planets/models/cuerpo_celeste.dart';
import 'package:planets/models/sistem.dart';
// Importa tus modelos y el helper de la base de datos aquí

class AddCuerpoCelesteScreen extends StatefulWidget {
  @override
  _AddCuerpoCelesteScreenState createState() => _AddCuerpoCelesteScreenState();
}

class _AddCuerpoCelesteScreenState extends State<AddCuerpoCelesteScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  File? _foto;
  String _descripcion = '';
  String _tipo = 'Estrella';
  String _naturaleza = 'Gas';
  double _tamano = 0.0;
  double _distancia = 0.0;
  int? _sistemaId; // Ahora es nullable
  // List<Map<String, dynamic>> _sistemas = [];
  List<Sistema> _sistemas = []; // Lista para almacenar sistemas

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _cargarSistemas();
  }

  Future<void> _cargarSistemas() async {
    List<Sistema> sistemasRecuperados =
        await DatabaseHelper.instance.getSistemas();
    setState(() {
      _sistemas = sistemasRecuperados;
    });
  }

  // Future cargarSistemas() async {
  //   // Aquí debes cargar los sistemas de tu base de datos
  //   // Por ejemplo, usando tu DatabaseHelper:
  //   // _sistemas = await DatabaseHelper.instance.getSistemas();
  //   // Por ahora, usaré una lista de ejemplo
  //   _sistemas = [
  //     {'id': 1, 'nombre': 'Sistema Solar'},
  //     {'id': 2, 'nombre': 'Alpha Centauri'}
  //     // Añade más sistemas aquí
  //   ];
  //   if (_sistemas.isEmpty) {
  //     _sistemas.add({'id': null, 'nombre': 'Desconocido'});
  //   }
  //   setState(() {});
  // }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _foto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Agregar Cuerpo Celeste'),
          backgroundColor: Color.fromARGB(255, 227, 69, 103)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            if (_foto != null) Image.file(_foto!),
            ElevatedButton.icon(
              onPressed: getImage,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 227, 69, 103),
                shape: CircleBorder(),
                padding: EdgeInsets.all(45.0),
              ),
              icon: Icon(Icons.camera_alt),
              label: Text('Tomar Foto'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
              onSaved: (value) => _nombre = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descripción',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
              onSaved: (value) => _descripcion = value!,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _tipo,
              items: <String>[
                'Estrella',
                'Planeta',
                'Asteroide',
                'Cometa',
                'Sin identificar'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _tipo = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Tipo',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _naturaleza,
              items: <String>['Gas', 'Líquido', 'Sólido', 'Rocoso']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _naturaleza = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Naturaleza',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tamaño en Km',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
              onSaved: (value) => _tamano = double.parse(value!),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Distancia con respecto a la Tierra',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
              onSaved: (value) => _distancia = double.parse(value!),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<int?>(
              value: _sistemaId,
              items: _sistemas.map<DropdownMenuItem<int?>>((Sistema sistema) {
                return DropdownMenuItem<int?>(
                  value: sistema.id,
                  child: Text(sistema.nombre),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _sistemaId = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Sistema',
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 227, 69, 103)),
                ),
                labelStyle: TextStyle(color: Color.fromARGB(255, 227, 69, 103)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Creando una instancia del modelo CuerpoCeleste
            CuerpoCeleste nuevoCuerpoCeleste = CuerpoCeleste(
              nombre: _nombre,
              foto: _foto?.path ?? '', // Guardar la ruta de la foto
              descripcion: _descripcion,
              tipo: _tipo,
              naturaleza: _naturaleza,
              tamano: _tamano,
              distancia: _distancia,
              sistemaId: _sistemaId,
            );

            // Guardar en la base de datos
            await DatabaseHelper.instance
                .insertCuerpoCeleste(nuevoCuerpoCeleste);

            // Mostrar un mensaje de confirmación
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cuerpo Celeste guardado con éxito')));

            // Devolver 'true' al cerrar para indicar que se ha añadido un cuerpo celeste
            Navigator.of(context).pop(true);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Color.fromARGB(255, 227, 69, 103),
      ),
    );
  }
}
