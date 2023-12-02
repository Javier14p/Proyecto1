import 'package:flutter/material.dart';
import 'package:planets/models/sistem.dart';
import 'dart:io';

class SistemaDescripcionScreen extends StatelessWidget {
  final Sistema sistema;

  SistemaDescripcionScreen({required this.sistema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Agrega aquí la lógica para manejar la acción de los tres puntos
            },
          ),
        ],
        elevation: 0,
        backgroundColor:
            const Color.fromARGB(0, 255, 255, 255), // Color transparente
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              width: double.infinity,
              height: 400,
              child: Image.asset(
                "assets/images/glov.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.file(
                      File(sistema.foto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${sistema.nombre}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Tamaño: ',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 178, 34),
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: '${sistema.tamano} km ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/tamano.png',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Distancia: ',
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 34, 34),
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: '${sistema.distancia} km ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/distancia.png',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Descripción',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 178, 34),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Container(
                              height: 2,
                              color: const Color.fromARGB(255, 255, 178, 34),
                              width: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'VR Tour',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Mapa',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    padding: EdgeInsets.all(30.0),
                    child: Text('${sistema.descripcion}'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.star),
                    Icon(Icons.location_on_rounded),
                    Icon(Icons.space_dashboard),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
