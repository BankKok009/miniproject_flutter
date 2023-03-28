import 'package:flutter/material.dart';
import 'package:my_mini_project/widgets/show_signout.dart';

class RiderService extends StatefulWidget {
  const RiderService({super.key});

  @override
  State<RiderService> createState() => _RiderServiceState();
}

class _RiderServiceState extends State<RiderService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
