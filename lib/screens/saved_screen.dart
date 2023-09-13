import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/detail_product_screen.dart';
import 'package:shop_app/widgets/product_item.dart';

class SavedScreen extends StatelessWidget {
  final List<Product> save;
  const SavedScreen({super.key, required this.save});

  @override
  Widget build(BuildContext context) {
    void _productDetail(BuildContext context, int id) {
      final prod = save.firstWhere((p) => p.id == id);
      // bool checkFav = save.contains(prod);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => DetailProductScreen(prod: prod)));
    }

    if (save.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidHeart,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No Item Saved',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
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
            children: save
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
