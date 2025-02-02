import 'package:flutter/material.dart';

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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    if (_fromKey.currentState!.validate()) {}
                  },
                  child: Text('Add'),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
