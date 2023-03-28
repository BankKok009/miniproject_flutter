import 'package:flutter/material.dart';

class ShowProgress extends StatelessWidget {
  const ShowProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
