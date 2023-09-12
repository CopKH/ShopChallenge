import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/screens/checkout_screen.dart';
import 'package:shop_app/screens/detail_product_screen.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/product_item.dart';

class CartScreen extends ConsumerWidget {
  final List<Cart> cart;
  const CartScreen(this.cart, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final numbers = <double>[10, 2, 5, 0.5];
    // final result =
    //     cart.reduce((value, element) => value.price * value.quantity);
    double total =
        cart.fold(0, (sum, item) => sum + item.price * item.quantity);
    void _productDetail(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => CheckoutScreen(price: total,
           )));
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CarItem(
                      cart: cart[index],
                    );
                  },
                  itemCount: cart.length,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Text('Total : \$ ${total}'),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      _productDetail(context);
                    },
                    child: Text('Checkout'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
