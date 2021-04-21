import 'package:flutter/material.dart';

class ManualAccesibilidad extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'ManualAccesibilidad',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('ManualAccesibilidad')),
            body: new ListView(children: [
              new ListTile(title: Text('Ingreso a la aplicacion:')),
              new ListTile(
                  title: Text(
                      'Debes poner tu usuario en el input de usuario y poner tu contraseña en el input de password para dar click al boton de ingresar. Alerta: debes tener una cuenta ya registrada e ingresar correctamente tus datos de ingreso para poder accesar a la aplicacion.')),
              new ListTile(title: Text('navegacion entre pantallas:')),
              new ListTile(title: Text('Registrarse en la aplicacion:')),
              new ListTile(
                  title: Text(
                      'Debes estar en el login y  ponerle en el link de (soy propietario) para crear una cuenta nueva, donde te pedira unos datos personales que deben ser llenado para poder generar una nueva cuenta. Alerta: los datos de email no puden ser repetidos.')),
              new ListTile(
                  title: Text(
                      'Al darle  click a los botones de retroseso  o a los botones de los productos podras cambiar de paginas ya sea propiamente a un producto en especifico (carro de compras) o regresar a la pagina anterior.')),
              new ListTile(title: Text('Agregar al carrito de compras')),
              new ListTile(
                  title: Text(
                      'Al estar en la seccion de productos puedes bajar o subir y  en su camino ir dandole click a los productos que quieras agragar al carrito para su compra; a su vez puedes ir a la seccion del carrito de compra para poder quitar los productos no deseados o para pagarlos en el momento.')),
              new ListTile(title: Text('Salir de la aplicaicon:')),
              new ListTile(
                  title: Text(
                      'Para poder salir de la aplicacion solamente es necesario darle click a todas las flechas (hacia atras) para llegar hasta el login.')),
              new ListTile(title: Text('Comprar articulos del carrito')),
              new ListTile(
                  title: Text(
                      'Tienes que ir a la seccion del carrito donde tienes tu listado de articulos que te interesan, solo debes darle click en la seccion de comprar para realizar la compra de productos.')),
              new ListTile(title: Text('Ir a las secciones de Manual')),
              new ListTile(
                  title: Text(
                      'En el menu, en la parte de arriba hay 2 botones para ir al manual del cliente o en cuyo caso del programador')),
              new ListTile(title: Text('Empresa: @JAZA'))
            ])));
  }
}
