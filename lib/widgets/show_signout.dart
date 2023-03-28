import 'package:flutter/material.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            final preferences = await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false),
                );
            ;
          },
          tileColor: Colors.red.shade900,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: ShowTitle(
            title: 'SignOut',
            textStyle: MyConstant().h2WhiteStyle(),
          ),
          subtitle: ShowTitle(
            title: 'Sign Out And Go to Login Page',
            textStyle: MyConstant().h3WhiteStyle(),
          ),
        ),
      ],
    );
  }
}
