import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../utils/constants.dart';
import '../widgets/main_drawer.dart';
import '../widgets/product_item.dart';
import 'product_details_page.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = '/product';

  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int? chipValue = 0;

  @override
  void didChangeDependencies() {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) =>
            Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categoryNameList.length,
                      itemBuilder: (context, index) {
                        final catName = provider.categoryNameList[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            labelStyle: TextStyle(color: chipValue == index ? Colors.white : Colors.black),
                            selectedColor: Theme.of(context).primaryColor,
                            label: Text(catName),
                            selected: chipValue == index,
                            onSelected: (value) {
                              setState(() {
                                chipValue = value? index : null;
                              });
                              if(chipValue != null && chipValue != 0) {
                                provider.getAllProductsByCategory(catName);
                              } else if(chipValue == 0) {
                                provider.getAllProducts();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  provider.productList.isEmpty
                      ? const Center(
                    child: Text(
                      'No item found',
                      style: TextStyle(fontSize: 18),
                    ),
                  ) : Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              childAspectRatio: 0.6),
                      itemCount: provider.productList.length,
                      itemBuilder: (context, index) {
                        final product = provider.productList[index];
                        return ProductItem(productModel: product);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
