import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/data/product_data.dart';

final productsProvider = Provider((ref) {
  return productData;
});

