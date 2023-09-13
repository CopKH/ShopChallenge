import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckoutScreen extends StatelessWidget {
  final double price;
  const CheckoutScreen({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Checkout',style: TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold
              ),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              QrImageView(
                data: 'https://payment.spw.challenge/checkout?price=${price}',
                version: QrVersions.auto,
                size: 250.0,
              ),
               SizedBox(
                height: 50,
              ),
              Text('Scan & Play',style: TextStyle(
                fontSize: 35,fontWeight: FontWeight.bold
              ),),
               SizedBox(
                height: 50,
              ),
              Text('\$${price}',style: TextStyle(
                fontSize: 35,fontWeight: FontWeight.bold
              ),),
            ]),
      ),
    );
  }
}
