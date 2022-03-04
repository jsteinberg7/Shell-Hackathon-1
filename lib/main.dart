import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shell_hackathon_1/scanner.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

import 'package:openfoodfacts/model/OcrIngredientsResult.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/TagType.dart';

void main() {
  runApp(const MyApp());
}

Future<Product> getProduct(String barcode) async {
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
  const MyApp({Key key}) : super(key: key);

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
          ),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.qr_code),
          label: Text('Scan'),
          onPressed: () async {
            String code = await scanBarcode();

            controller.text = code;

            await Vibration.vibrate();
            Product product = await getProduct(code);
            showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      child:
                          Center(child: Image.network(product.images[0].url)));
                });
          },
        )
      ],
    );
  }
}
