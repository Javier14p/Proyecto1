import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:planets/db/database_helper.dart';
import 'package:planets/models/cuerpo_celeste.dart';
import 'package:planets/models/sistem.dart';

import 'package:planets/screens/add_cuerpo_celeste_screen.dart';
import 'package:planets/screens/add_sistema_screen.dart';
import 'package:planets/screens/cuerpo_celeste_descripcion_screen.dart';
import 'package:planets/screens/sistema_descripcion_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Sistema> _sistemas = [];
  List<CuerpoCeleste> _cuerposCelestes = [];
  List<CuerpoCeleste> _cuerposFiltrados = [];
  String _filtroTipo = 'Todos';

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    _sistemas = await DatabaseHelper.instance.getSistemas();
    _cuerposCelestes = await DatabaseHelper.instance.getCuerposCelestes();
    _filtrarCuerpos();
  }

  void _filtrarCuerpos() {
    setState(() {
      if (_filtroTipo == 'Todos') {
        _cuerposFiltrados = _cuerposCelestes;
      } else {
        _cuerposFiltrados = _cuerposCelestes
            .where((cuerpo) => cuerpo.tipo == _filtroTipo)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Planetas',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                height: 0,
                fontSize: 30),
          ),
          backgroundColor:
              Color.fromARGB(255, 241, 223, 207), // Cambia el color aquí
          elevation: 0, // Establece la elevación a 0 para quitar la sombra
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey, // Color del borde
                  width: 1.0, // Grosor del borde
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.grey[800]),
                onPressed: () => _navegarYActualizar(AddSistemaScreen()),
              ),
            ),
            SizedBox(width: 10), // Un espacio opcional entre los botones
            Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey, // Color del borde
                  width: 1.0, // Grosor del borde
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.grey[800]),
                onPressed: () {
                  // Implementa la funcionalidad de búsqueda si es necesario
                },
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 0,
                  left: 19.0,
                  bottom: 40), // Ajusta el valor del margen como desees
              child: Text(
                'Sistemas Solares',
                style: TextStyle(
                  height: 0,
                  fontSize: 15,
                  color: const Color.fromARGB(255, 139, 139, 139),
                ),
              ),
            ),
            _crearCarruselSistemas(),
            _crearFiltros(),
            _crearGridCuerposCelestes(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarYActualizar(AddCuerpoCelesteScreen()),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navegarYActualizar(Widget pantalla) async {
    final resultado = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => pantalla),
    );

    if (resultado == true) {
      _cargarDatos();
    }
  }

  Widget _crearCarruselSistemas() {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0, autoPlay: true),
      items: _sistemas.map((sistema) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      SistemaDescripcionScreen(sistema: sistema),
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(
                      15.0), // Borde redondeado para el contenedor
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15.0), // Asegura que la imagen también tenga el borde redondeado
                  child: Image.file(
                    File(sistema.foto),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons
                          .error); // Icono de error si la imagen no se carga
                    },
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _crearFiltros() {
    List<String> tipos = [
      'Todos',
      'Estrella',
      'Planeta',
      'Asteroide',
      'Cometa',
      'Sin identificar'
    ];

    return Container(
      height: 50, // Ajusta la altura según sea necesario
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tipos.length,
        itemBuilder: (context, index) {
          String tipo = tipos[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: FilterChip(
              label: Text(tipo),
              selected: _filtroTipo == tipo,
              onSelected: (bool selected) {
                setState(() {
                  _filtroTipo = tipo;
                  _filtrarCuerpos();
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _crearGridCuerposCelestes() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: _cuerposFiltrados.length,
      itemBuilder: (context, index) {
        CuerpoCeleste cuerpo = _cuerposFiltrados[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CuerpoCelesteDescripcionScreen(cuerpoCeleste: cuerpo),
            ));
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.file(
                    File(cuerpo.foto),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons
                          .error); // Icono de error si la imagen no se carga
                    },
                  ),
                ),
                Text(cuerpo.nombre),
              ],
            ),
          ),
        );
      },
    );
  }
}
