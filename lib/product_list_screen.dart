import 'package:flutter/material.dart';
import 'package:shopping/product_add_from.dart';
import 'package:shopping/product_update.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, int index) {
          return buildProductList();
        },
        separatorBuilder: (_, __) => Divider(),
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
                _showProdcutDeletConfig();
              },
              icon: Icon(Icons.delete))
        ],
      ),
    );
  }

  void _showProdcutDeletConfig() {
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
