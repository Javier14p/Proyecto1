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
      body: Column(
        children: <Widget>[
          // Coloca aquí el texto y los botones
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Planetas',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AddSistemaScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implementa la funcionalidad de búsqueda
                  },
                ),
              ],
            ),
          ),
          // El resto de tu contenido
          Text('Sistemas Solares'),
          _crearCarruselSistemas(),
          _crearFiltros(),
          _crearGridCuerposCelestes(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddCuerpoCelesteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _crearCarruselSistemas() {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
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
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Image.file(
                  File(sistema.foto),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                        Icons.error); // Icono de error si la imagen no se carga
                  },
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
