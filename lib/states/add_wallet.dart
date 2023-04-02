import 'package:flutter/material.dart';
import 'package:my_mini_project/bodys/bank.dart';
import 'package:my_mini_project/bodys/credic.dart';
import 'package:my_mini_project/bodys/prompay.dart';
import 'package:my_mini_project/utility/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({super.key});

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Prompay(),
    Credic(),
  ];
  List<IconData> icons = [
    Icons.money,
    Icons.book,
    Icons.credit_card,
  ];
  List<String> titles = [
    'Bank',
    'Prompay',
    'Credit',
  ];
  List<BottomNavigationBarItem> bottomNavigatorBarItems = [];
  int indexPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 0;
    for (var element in titles) {
      bottomNavigatorBarItems.add(
        createBottomNavigationBarItem(icons[i], element),
      );
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet form ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: MyConstant.dark),
        unselectedIconTheme: IconThemeData(color: MyConstant.light),
        selectedItemColor: MyConstant.dark,
        unselectedItemColor: MyConstant.light,
        items: bottomNavigatorBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
