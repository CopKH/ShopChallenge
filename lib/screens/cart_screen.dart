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
    double total =
        cart.fold(0, (sum, item) => sum + item.price * item.quantity);
    void _productDetail(BuildContext context) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => CheckoutScreen(
                price: total,
              )));
    }

    if (cart.isEmpty) {
      return const Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.cartShopping,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No Cart Item',
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
