import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class NavConfirmAddWallet extends StatelessWidget {
  const NavConfirmAddWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      // height: 80,
      child: InkWell(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
            context, MyConstant.routeConfirmAddWallet, (route) => false),
        child: Card(
          color: MyConstant.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images/bill2.png'),
                ShowTitle(title: 'Confirm'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
