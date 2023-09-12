class Cart {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  late int quantity;

   Cart(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required  this.quantity});
}
