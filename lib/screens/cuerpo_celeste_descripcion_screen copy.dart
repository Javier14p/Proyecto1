import 'package:flutter/material.dart';
import 'package:planets/models/cuerpo_celeste.dart';
import 'dart:io';

class CuerpoCelesteDescripcionScreen extends StatelessWidget {
  final CuerpoCeleste cuerpoCeleste;

  CuerpoCelesteDescripcionScreen({required this.cuerpoCeleste});

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
            Color.fromARGB(255, 227, 69, 103), // Color transparente
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: Image.asset(
              "assets/images/glov.png",
              fit: BoxFit.cover,
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
                      File(cuerpoCeleste.foto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35.0, 20.0, 30.0, 20),
                  child: Text(
                    '${cuerpoCeleste.nombre}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35.0, 0.0, 35, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Tipo: ',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 178, 34),
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${cuerpoCeleste.tipo} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              child: Image.asset(
                                'assets/images/${cuerpoCeleste.tipo.toLowerCase()}.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Naturaleza: ',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 34, 34),
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${cuerpoCeleste.naturaleza} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              child: Image.asset(
                                'assets/images/${cuerpoCeleste.naturaleza}.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10, 40),
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
                                  text: '${cuerpoCeleste.tamano} km ',
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
                                  text: '${cuerpoCeleste.distancia} Mkm ',
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
                Padding(
                  padding: EdgeInsets.only(
                      top: 10), // Ajusta este valor según necesites
                  child: Text(cuerpoCeleste.nombre),
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
                    height: 320,
                    padding: EdgeInsets.all(30.0),
                    child: Text('${cuerpoCeleste.descripcion}'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 105, 105, 105),
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      color: const Color.fromARGB(255, 105, 105, 105),
                    ),
                    Icon(
                      Icons.space_dashboard,
                      color: const Color.fromARGB(255, 105, 105, 105),
                    ),
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
