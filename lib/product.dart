class Product {
  //api product data

  final String productName;
  final String productCode;
  final String image;
  final String productPrice;
  final String productQuantity;
  final String totalPrice;

  Product(
      {required this.productName,
      required this.productCode,
      required this.image,
      required this.productPrice,
      required this.productQuantity,
      required this.totalPrice});
}
