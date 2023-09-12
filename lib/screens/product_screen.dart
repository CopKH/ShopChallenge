import 'package:flutter/material.dart';
import 'package:shop_app/data/product_data.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/detail_product_screen.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductScreen extends StatelessWidget {
  final List<Product> product;
  final List<Product> save;
  const ProductScreen({super.key, required this.product, required this.save});

  @override
  Widget build(BuildContext context) {
    void _productDetail(BuildContext context, int id) {
      final prod = product.firstWhere((p) => p.id == id);
      // bool checkFav = save.contains(prod);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => DetailProductScreen(prod: prod )));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: product
                .map((data) => ProductItem(
                      data: data,
                      Press: () {
                        _productDetail(context, data.id);
                      },
                      save: save,
                    ))
                .toList()),
      ),
    );
  }
}
