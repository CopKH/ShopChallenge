import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/favorites_provider.dart';

class DetailProductScreen extends ConsumerWidget {
  final Product prod;

  const DetailProductScreen({super.key, required this.prod});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(save);
    // final prod = ref.watch(productsProvider);
    final cart = ref.watch(cartProvider);
    final saveProduct = ref.watch(favoriteProductProvider);
    void _shonwMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ));
    }

    return Scaffold(
      appBar: AppBar(
          // title: Text('aaa'),
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          // height: 500,
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(prod.imageUrl),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            prod.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: saveProduct.contains(prod)
                              ? Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.red,
                                )
                              : Icon(FontAwesomeIcons.heart),
                          onPressed: () {
                            saveProduct.contains(prod)
                                ? _shonwMessage('UNSAVED')
                                : _shonwMessage('SAVED');
                            ref
                                .read(favoriteProductProvider.notifier)
                                .toggleProductFavoriteStatus(prod);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(
                      '\$${prod.price}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      final add = Cart(
                          id: prod.id,
                          name: prod.name,
                          imageUrl: prod.imageUrl,
                          price: prod.price,
                          quantity: 1);
                      Cart? val = cart
                          .firstWhereOrNull((element) => element.id == prod.id);
                      if (null == val) {
                        print('ADD');
                        ref.read(cartProvider.notifier).addItemToCart(add);
                      } else {
                        print('UPDATE');
                        ref
                            .read(cartProvider.notifier)
                            .updateItemQuantity(prod.id);
                      }
                      _shonwMessage('ADD ${prod.name} To Cart');

                      // ref.read(cartProvider.notifier).addItemToCart(add);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
