import 'package:flutter/material.dart';
import 'dart:async';

import 'package:openfoodfacts/model/OcrIngredientsResult.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/TagType.dart';

void main() {
  runApp(const MyApp());
}

Future<Product?> getProduct(String barcode) async {
  ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
      language: OpenFoodFactsLanguage.GERMAN, fields: [ProductField.ALL]);
  ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

  if (result.status == 1) {
    return result.product;
  } else {
    throw Exception('product not found, please insert data for ' + barcode);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Foodie';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar:
            AppBar(title: const Text(appTitle), backgroundColor: Colors.green),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              icon: Icon(Icons.qr_code),
              labelText: 'Barcode *',
              border: UnderlineInputBorder(),
            ),
            maxLength: 10,
          ),
        ),
        ElevatedButton.icon(
            icon: Icon(Icons.qr_code), label: Text('Submit'), onPressed: () {})
      ],
    );
  }
}
