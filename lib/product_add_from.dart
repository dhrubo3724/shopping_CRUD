import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductAddFrom extends StatefulWidget {
  const ProductAddFrom({super.key});

  @override
  State<ProductAddFrom> createState() => _ProductAddFromState();
}

class _ProductAddFromState extends State<ProductAddFrom> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();

  bool _addButtoninProgess = false;

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Add"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameTEController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Product Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _priceTEController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    labelText: 'Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product Price';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _quantityTEController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Product Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _totalPTEController,
                  decoration: InputDecoration(
                    hintText: 'Total Price ',
                    labelText: 'Total Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your Total price';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _imageTEController,
                    decoration: InputDecoration(
                      hintText: 'Image',
                      labelText: 'Image',
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Add your image';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _addButtoninProgess = false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        _addProduct();
                      }
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//API intrigation
//step:1 = set the url
  Future<void> _addProduct() async {
    _addButtoninProgess = true;
    setState(() {});
    const String addNewProduct = 'api link';
    //step:2 = prepare data

    Map<String, dynamic> inputData = {"Img": "sunffj"};

    //step:3 =parse
    Uri uri = Uri.parse(addNewProduct);
    //step:4 = send request
    Response response = await post(uri,
        body: jsonEncode(inputData),
        headers: {'content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);
    print(response.headers);
    _addButtoninProgess = false;
    setState(() {});

    if (response.statusCode == 200) {
      _nameTEController.clear();
      _priceTEController.clear();
      _quantityTEController.clear();
      _imageTEController.clear();
      _totalPTEController.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Product Added")));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add new product failed!")))
    }
  }

  //TODO:from clear
  //TODO:Add button in progress
  //TODO:toast add

  @override
  void dispose() {
    _imageTEController.dispose();
    _totalPTEController.dispose();
    _quantityTEController.dispose();
    _priceTEController.dispose();
    _nameTEController.dispose();

    super.dispose();
  }
}
