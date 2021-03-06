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
            onEditingComplete: () {
              print("doen editing");
            },
            controller: controller,
            decoration: const InputDecoration(
              labelText: ('Barcode *'),
              labelStyle: TextStyle(
                color: Colors.green,
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.green,
              )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.green,
              )),
              fillColor: Colors.green,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () async {
                Product product = await getProduct(controller.text);
                showBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    context: context,
                    builder: (context) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          // color: Colors.grey,
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                              child: Image.network(
                            product.images[0].url,
                            height: 400,
                            width: 400,
                            fit: BoxFit.contain,
                          )));
                    });
              },
              label: Text("Submit"),
              icon: Icon(Icons.check),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              icon: Icon(Icons.qr_code),
              label: Text('Scan'),
              onPressed: () async {
                String code = await scanBarcode();

                controller.text = code;

<<<<<<< HEAD
                await Vibration.vibrate();
                Product product = await getProduct(code);
                showBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    context: context,
                    builder: (context) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          // color: Colors.grey,
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                              child: Image.network(
                            product.images[0].url,
                            height: 400,
                            width: 400,
                            fit: BoxFit.contain,
                          )));
                    });
              },
            ),
          ],
=======
            await Vibration.vibrate();
            Product product = await getProduct(code);
            showBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                context: context,
                builder: (context) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      // color: Colors.grey,
                      height: MediaQuery.of(context).size.height - 200,
                      child: Column(children: [
                        Center(
                            child: Image.network(
                          product.images[0].url,
                          height: 400,
                          width: 400,
                          fit: BoxFit.contain,
                        )),
                        Center(
                            child: Text("label: " +
                                product.productName))
                      ]));
                });
          },
>>>>>>> 15e0fbd316f0195812c160199e545e9592c5e907
        )
      ],
    );
  }
}
