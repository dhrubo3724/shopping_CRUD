import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping/product.dart';

class ProductUpdate extends StatefulWidget {
  const ProductUpdate({super.key, required this.product});

  final Product product;

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  bool _productUpdateInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName;
    _priceTEController.text = widget.product.productPrice;
    _quantityTEController.text = widget.product.productQuantity;
    _totalPTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Update"),
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
                  visible: _productUpdateInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        _updateProduct();
                      }
                    },
                    child: Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _productUpdateInProgress = true;

    setState(() {});
    Map<String, String> inputData = {
      "img": _imageTEController.text,
    };
    String updateProductUrl = " url /${widget.product.productCode}";
    Uri uri = Uri.parse(updateProductUrl);

    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product updateded")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("update product failed!")));
    }
  }

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
