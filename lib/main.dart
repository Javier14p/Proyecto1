// import 'package:flutter/material.dart';
// import 'package:planets/db/database_helper.dart'; // Asegúrate de importar DatabaseHelper
// import 'package:planets/models/cuerpo_celeste.dart';
// import 'package:planets/models/sistem.dart';
// import 'package:planets/screens/add_cuerpo_celeste_screen.dart';
// import 'package:planets/screens/add_sistema_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Registro de Cuerpos Celestes',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   // Método para imprimir los datos en consola
//   void _mostrarDatos() async {
//     List<CuerpoCeleste> cuerpos =
//         await DatabaseHelper.instance.getCuerposCelestes();
//     List<Sistema> sistemas = await DatabaseHelper.instance.getSistemas();

//     print('Cuerpos Celestes:');
//     cuerpos.forEach((cuerpo) =>
//         print('${cuerpo.foto},${cuerpo.nombre}, ${cuerpo.descripcion}, ...'));

//     print('Sistemas:');
//     sistemas.forEach(
//         (sistema) => print('${sistema.nombre}, ${sistema.descripcion}, ...'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Página Principal'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               child: Text('Agregar Cuerpo Celeste'),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                       builder: (context) => AddCuerpoCelesteScreen()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: Text('Agregar Sistema'),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AddSistemaScreen()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: Text('Mostrar Datos Guardados'),
//               onPressed: _mostrarDatos,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:planets/screens/main_screen.dart'; // Importa MainScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Cuerpos Celestes',
      theme: ThemeData(
        // Define el tema global de la aplicación
        scaffoldBackgroundColor: Color.fromARGB(
            255, 241, 223, 207), // Cambia esto por tu color deseado
      ),
      home: MainScreen(), // Usando MainScreen como pantalla de inicio
    );
  }
}
