
import 'package:ecom_user_batch06/models/product_model.dart';
import 'package:ecom_user_batch06/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final ProductModel productModel;

  const ProductItem({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Expanded(
            child: FadeInImage.assetNetwork(
              fadeInDuration: const Duration(seconds: 2),
              fadeInCurve: Curves.bounceInOut,
              placeholder: 'images/placeholder.jpg',
              image: widget.productModel.imageUrl!,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productModel.name!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            '$currencySymbol${widget.productModel.salesPrice!}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            label: const Text('ADD'),
          )
        ],
      ),
    );
  }
}
