import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bloc/cart_items_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final userController = TextEditingController();
final passController = TextEditingController();

var fail = 0;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/token.txt');
}

_write(String text) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/token.txt');
  await file.writeAsString(text);
  print(text);
}

Future<String> _read() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/token.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}

_fetchVet() async {
  fail = 0;
  Map<String, String> body = {
    'user': '${userController.text}',
    'password': '${passController.text}'
  };
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request =
      http.Request('POST', Uri.parse('http://192.168.56.1:19000/user'));
  request.bodyFields = body;
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var izzi = await response.stream.bytesToString();
    var aux = izzi.split(':');
    var aux2 = aux[3].split(',');
    print(response.reasonPhrase);
    if (aux2[0] != "null") {
      _write(aux2[0]);
      print(response.statusCode);
      fail = 1;
    }
  }
}

class Login extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle_outlined,
                        size: 160.0,
                        color: Colors.grey,
                      ),
                      Text(
                        'Bienvenido de vuelta',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          child: Text(
                        "Inicia para continuar",
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      SizedBox(height: 30.0),
                      _email(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _password(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromRGBO(50, 205, 50, 1.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            await _fetchVet();
                            if (fail == 1) {
                              await bloc.estadoInicial();
                              Navigator.pushNamed(context, '/');
                            }
                          },
                          padding: EdgeInsets.all(15.0),
                          color: Color.fromRGBO(48, 194, 139, 1.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an Account? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                              ),
                              TextSpan(
                                text: 'create a new account',
                                style: TextStyle(
                                  color: Color.fromRGBO(50, 205, 50, 1.0),
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/accesibilidad'),
                          padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            'Manual de accesibilidad',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/programador'),
                          padding: EdgeInsets.all(15.0),
                          color: Colors.white,
                          child: Text(
                            'Manual de programador',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Email
  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: userController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Enter your Email',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: passController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              hintText: 'PASSWORD',
            ),
          ),
        ),
      ],
    );
  }
}
