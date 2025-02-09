import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopping/product.dart';
import 'package:shopping/product_add_from.dart';
import 'package:shopping/product_update.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _productListInProgress = false;
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
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _productListInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, int index) {
              return buildProductList(productList[index]);
            },
            separatorBuilder: (_, __) => Divider(),
          ),
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
    _productListInProgress = true;
    setState(() {});
    productList.clear();
    const String url = " //api Url";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      //data decode
      final decodedData = jsonDecode(response.body);
      //get the list
      final jsonProductList = decodedData['//from api data'];

      //Loop over the list

      for (Map<String, dynamic> p in jsonProductList) {
        Product product = Product(
            productName: p['_productName' /* from api data*/] ?? '',
            productCode: p['productCode'] ?? '',
            image: p['image'] ?? '',
            productPrice: p['productPrice'] ?? '',
            productQuantity: p['productQuantity'] ?? '',
            totalPrice: p['totalPrice'] ?? '');
        productList.add(product);
      }
      _productListInProgress = false;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Add new product failed!")));
    }
  }

  Widget buildProductList(Product product) {
    return ListTile(
      // leading: Image.asset(
      //   'assets/images/shoes.png',
      //   height: 60,
      //   width: 60,
      // ),
      title: Text(product.productName),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text("Unit Price:${product.productPrice}"),
          Text("Quantity:${product.productQuantity}"),
          Text("Total price: ${product.totalPrice}")
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductUpdate(
                    product: product,
                  ),
                ),
              );
              if (result == true) {
                _getProductList();
              }
            },
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

  void _showProductDeleteConfig( String productID) {
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
                  _deleteProduct,
                  Navigator.pop(context);
                },
                child: Text("Yes,Delete"),
              )
            ],
          );
        });
  }

  Future<void> _deleteProduct(String productID) async {
    _productListInProgress = true;
    setState(() {});
    String deleteUrl = "delete_api url /$productID";
    Uri uri = Uri.parse(deleteUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _productListInProgress = false;
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Delete product failed! try again "),
        ),
      );
    }
  }
}
