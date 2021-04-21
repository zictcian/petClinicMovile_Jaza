import 'package:flutter/material.dart';

class ManualProgramador extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Manueal del programador',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('Manual del programador')),
            body: new ListView(children: [
              new ListTile(title: Text('Base de datos: PetClinic')),
              new ListTile(title: Text('Gestor de base de datos: XAMPP')),
              new ListTile(title: Text('Lenguaje: Dart')),
              new ListTile(title: Text('Lenguaje: Kotlin')),
              new ListTile(title: Text('Lenguaje: HTML')),
              new ListTile(title: Text('Herramienta: Visual studio code')),
              new ListTile(title: Text('Emulador: Xiaomi Nux pro')),
              new ListTile(title: Text('Inicio: main.dart')),
              new ListTile(title: Text('Tablas a implementar: Productos')),
              new ListTile(title: Text('Tablas a implementar: Users')),
              new ListTile(title: Text('Roles a implementar: Owners')),
              new ListTile(title: Text('Tipo Programacion: Movile')),
              new ListTile(title: Text('librerias: material.Dart')),
              new ListTile(title: Text('Metodologia: Scrum')),
              new ListTile(title: Text('.........Documentacion.......')),
              new ListTile(
                  title: Text(
                      'Link de trello: https://trello.com/b/6vIZL83n/petclinic-ca-de-cv')),
              new ListTile(
                  title: Text(
                      'link de github: https://github.com/zictcian/petClinicMovile_Jaza')),
              new ListTile(title: Text('Empresa: JAZA'))
            ])));
  }
}
