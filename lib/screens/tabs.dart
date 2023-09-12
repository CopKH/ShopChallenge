import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:shop_app/providers/product_providers.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_screen.dart';
import 'package:shop_app/screens/saved_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _pageIndex = 0;
  String _titleIndex = 'For you';
  void _selectPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prod = ref.watch(productsProvider);
    final saveProduct = ref.watch(favoriteProductProvider);
    final cart = ref.watch(cartProvider);
    Widget activePage = ProductScreen(
      product: prod,
      save: saveProduct,
    );
    if (_pageIndex == 0) {
      setState(() {
        _titleIndex = 'For you';
      });
    }
    if (_pageIndex == 1) {
      setState(() {
        _titleIndex = 'Save';
      });
      activePage = SavedScreen(
        save: saveProduct,
      );
    }
    if (_pageIndex == 2) {
      setState(() {
        _titleIndex = 'Cart';
      });
      activePage = CartScreen(cart);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(_titleIndex),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidHeart), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cartShopping), label: 'Cart'),
        ],
        onTap: _selectPage,
        currentIndex: _pageIndex,
      ),
    );
  }
}
