import 'package:flutter/material.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_signout.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({super.key});

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
