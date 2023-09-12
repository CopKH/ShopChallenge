import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/favorites_provider.dart';

class ProductItem extends ConsumerWidget {
  final Product data;
  final List<Product> save;
  final void Function() Press;
  const ProductItem({
    super.key,
    required this.data,
    required this.save,
    required this.Press,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: Press,
      child: Container(
        height: 500,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data.imageUrl),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: save.contains(data)
                          ? Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            )
                          : Icon(FontAwesomeIcons.heart),
                      onPressed: () {
                        ref
                            .read(favoriteProductProvider.notifier)
                            .toggleProductFavoriteStatus(data);
                      },
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name),
                  Text('\$${data.price}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
