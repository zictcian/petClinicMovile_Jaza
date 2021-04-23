/// The [dart:async] is neccessary for using streams
import 'dart:convert';
import 'dart:convert' show utf8;
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

var aux = "";
var carId = "";
var primera = 1;
Future<String> _read() async {
  String text;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/token.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file 2");
  }
  aux = text;
  return text;
}

class CartItemsBloc {
  var data;

  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;
//aqui van los productos papi
//
//192.168.56.1:19000/API/productsJSON
//
//

  final Map allItems = {'shop items': [], 'cart items': []};

  void llenarProducto() {
    for (var i = 0; i < data.length; i++) {
      Map valueMap = json.decode(data[i]);
      allItems['shop items'].add(valueMap);
    }
  }

  void addToCart(item) {
    allItems['shop items'].remove(item);
    allItems['cart items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  Future pago() async {
    await _read();
    var token = aux;
    var token_aux = token.split('Bearer');
    var token_com = token_aux[1].split('"');

    var token_user = token_com[0];
    var headers = {
      'Authorization': 'Bearer $token_user',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT', Uri.parse('http://192.168.50.128:19000/API/update-order/'));
    request.body =
        '''{\r\n    "id": $carId,\r\n    "date": "2021-04-23",\r\n    "total": 0.0,\r\n    "method_payment": "Efectivo",\r\n    "ownerId": 2,\r\n    "status": 1,\r\n    "new": false\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future orden() async {
    await _read();
    var token = aux;
    var token_aux = token.split('Bearer');
    var token_com = token_aux[1].split('"');

    var token_user = token_com[0];
    var headers = {
      'Authorization': 'Bearer $token_user',
      'Content-Type': 'application/json'
    };

    for (var i = 0; i < allItems['cart items'].length; i++) {
      var gg = allItems['cart items'][i]['id'];
      var request = http.Request(
          'POST', Uri.parse('http://192.168.50.128:19000/API/order/create/2'));
      request.body = '{"quantity": 1,"productId": $gg ,"orderId": 1}';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
        var izzi = await response.stream.bytesToString();
        var aux = izzi.split(',"date');
        var aux2 = aux[0].split('{"id":');
        carId = aux2[1];
        await pago();
      }
    }
    print("aqui1");
  }

  Future estadoInicial() async {
    await _read();
    var token = aux;
    var token_aux = token.split('Bearer');
    var token_com = token_aux[1].split('"');

    var token_user = token_com[0];

    Map<String, String> headers = await {"Authorization": 'Bearer $token_user'};
    print(headers);
    var request = http.Request(
        'GET', Uri.parse('http://192.168.50.128:19000/API/productsJSON'));
    request.bodyFields = {};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var izzi = await response.stream.bytesToString();
      var aux = izzi.split('{"productList":[');
      var aux2 = aux[1].split(']}');
      data = aux2[0].split(RegExp(r'(?<=\}),(?=\{)'));
      if (primera == 1) {
        primera = 0;
        llenarProducto();
      }
    } else {
      print(await response.stream.bytesToString());
    }
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();
