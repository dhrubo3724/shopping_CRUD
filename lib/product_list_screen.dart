import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping/product_add_from.dart';
import 'package:shopping/product_update.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _ProductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: Visibility(
        visible: _ProductListInProgress == false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
          itemCount: productList.length,
          itemBuilder: (context, int index) {
            return buildProductList();
          },
          separatorBuilder: (_, __) => Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAddFrom()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    _ProductListInProgress = true;
    setState(() {});
    const String url = " //api Url";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      //data decode
      final decodedData = jsonDecode(response.body);
      //get the list
      List<Map<String, dynamic>> productList = decodedData['//from api data'];

      //Loop over the list

      for (Map<String, dynamic> p in productList) {}
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add new product failed!")));
    }
  }

  Widget buildProductList() {
    return ListTile(
      leading: Image.asset(
        'assets/images/shoes.png',
        height: 60,
        width: 60,
      ),
      title: Text("Product Name"),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text("Unit Price:10"),
          Text("Quantity:2"),
          Text("Total price:100")
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductUpdate()),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
              onPressed: () {
                _showProductDeleteConfig();
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }

  void _showProductDeleteConfig() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text("Are you sure ?you want to delete this product?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Yes,Delete"),
              )
            ],
          );
        });
  }
}

class Product {
  //api product data

  final String productName;
  final String productCode;
  final String image;
  final String productPrice;
  final String productQuantity;

  Product(
      {required this.productName,
      required this.productCode,
      required this.image,
      required this.productPrice,
      required this.productQuantity});
}
