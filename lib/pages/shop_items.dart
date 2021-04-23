import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../bloc/cart_items_bloc.dart';
import 'package:flutter/material.dart';

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

class ShopItems extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PetClinic Compras'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              bloc.estadoInicial();
            },
            //() => Navigator.pushNamed(context, '/checkout');
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_sharp),
            onPressed: () => Navigator.pushNamed(context, '/checkout'),
            //() => Navigator.pushNamed(context, '/checkout');
          ),
        ],
      ),
      body: ShopItemsWidget(),
    );
  }
}

class ShopItemsWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: bloc.allItems,
      stream: bloc.getStream,
      builder: (context, snapshot) {
        return snapshot.data["shop items"].length > 0
            ? shopItemsListBuilder(snapshot)
            : Center(child: Text("Sin existencias"));
      },
    );
  }
}

Widget shopItemsListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["shop items"].length,
    itemBuilder: (BuildContext context, i) {
      final shopList = snapshot.data["shop items"];
      return ListTile(
        title: Text(shopList[i]['name']),
        subtitle: Text("\$${shopList[i]['price']}"),
        trailing: IconButton(
          icon: Icon(Icons.plus_one),
          onPressed: () {
            bloc.addToCart(shopList[i]);
          },
        ),
        onTap: () {},
      );
    },
  );
}
