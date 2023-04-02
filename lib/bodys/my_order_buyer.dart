import 'package:flutter/material.dart';

class MyOrderBuyer extends StatefulWidget {
  const MyOrderBuyer({super.key});

  @override
  State<MyOrderBuyer> createState() => _MyOrderBuyerState();
}

class _MyOrderBuyerState extends State<MyOrderBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('My Order Buyer'),
    );
  }
}
