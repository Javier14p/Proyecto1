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
          icon: Icon(Icons.arrow_back,
              color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,
                color: const Color.fromARGB(
                    255, 255, 255, 255)), // Icono de tres puntos
            onPressed: () {
              // Agrega aquí la lógica para manejar la acción de los tres puntos
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 241, 223, 207),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                width: 250, // Ancho igual al alto para un círculo perfecto
                height: 250, // Alto de la imagen
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      125.0), // La mitad del ancho y alto para un círculo perfecto
                ),
                clipBehavior: Clip.antiAlias, // Recorta con el borde redondeado
                child: Image.file(
                  File(sistema.foto),
                  fit: BoxFit
                      .cover, // Ajusta el fit para mantener las proporciones de la imagen
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
                                color: const Color.fromARGB(255, 255, 178,
                                    34), // Color naranja para la etiqueta "Tamaño"
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${sistema.tamano} km ',
                              style: TextStyle(
                                color:
                                    Colors.black, // Color negro para el valor
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold, // Negrita para el valor
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
                                color: const Color.fromARGB(255, 255, 34,
                                    34), // Color naranja para la etiqueta "Distancia"
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${sistema.distancia} km ',
                              style: TextStyle(
                                color:
                                    Colors.black, // Color negro para el valor
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold, // Negrita para el valor
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
                          color: const Color.fromARGB(255, 255, 178,
                              34), // Color naranja para "Descripción"
                          fontWeight: FontWeight.bold, // Negrita
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top:
                                8), // Controla la distancia de la línea desde el texto
                        child: Container(
                          height: 2, // Grosor de la línea
                          color: const Color.fromARGB(
                              255, 255, 178, 34), // Color de la línea
                          width: 80, // Ancho de la línea
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
                      color: Colors.grey, // Color gris para "VR Tour"
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Mapa',
                    style: TextStyle(
                      color: Colors.grey, // Color gris para "Mapa"
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:
                    300, // Ajusta este valor para establecer la altura deseada
                padding:
                    EdgeInsets.all(30.0), // Agrega padding interno al Container
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
    );
  }
}
