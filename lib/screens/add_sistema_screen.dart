import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planets/db/database_helper.dart';
import 'dart:io';

import 'package:planets/models/sistem.dart';
// Importa tu modelo Sistema y el DatabaseHelper aquí

class AddSistemaScreen extends StatefulWidget {
  @override
  _AddSistemaScreenState createState() => _AddSistemaScreenState();
}

class _AddSistemaScreenState extends State<AddSistemaScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  File? _foto;
  String _descripcion = '';
  double _tamano = 0.0;
  double _distancia = 0.0;

  final picker = ImagePicker();

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
          title: Text('Agregar Sistema'),
          backgroundColor: Color.fromARGB(255, 227, 69, 103)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            if (_foto != null) Image.file(_foto!),
            Center(
              child: ElevatedButton.icon(
                onPressed: getImage,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 227, 69, 103),
                  shape: CircleBorder(), // Hace que el botón sea circular
                  padding: EdgeInsets.all(
                      45.0), // Ajusta el padding según sea necesario
                ),
                icon: Icon(Icons.camera_alt), // Icono de cámara
                label: Text('Tomar Foto'),
              ),
            ),
            SizedBox(height: 16.0), // Ajusta el espacio según sea necesario
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true, // Establece el fondo blanco
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Creando una instancia del modelo Sistema
            Sistema nuevoSistema = Sistema(
              nombre: _nombre,
              foto: _foto?.path ?? '', // Guardar la ruta de la foto
              descripcion: _descripcion,
              tamano: _tamano,
              distancia: _distancia,
            );

            // Guardar en la base de datos
            await DatabaseHelper.instance.insertSistema(nuevoSistema);

            // Mostrar un mensaje de confirmación
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sistema guardado con éxito')));

            // Devolver 'true' al cerrar para indicar que se ha añadido un sistema
            Navigator.of(context).pop(true);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Color.fromARGB(255, 227, 69, 103),
      ),
    );
  }
}
