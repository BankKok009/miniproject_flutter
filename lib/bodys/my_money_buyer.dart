import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/bodys/approve.dart';
import 'package:my_mini_project/bodys/wait.dart';
import 'package:my_mini_project/bodys/wallet.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({super.key});

  @override
  State<MyMoneyBuyer> createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  int indexWidget = 0;
  var widgets = <Widget>[
    Wallet(),
    Approve(),
    Wait(),
  ];

  var titles = <String>[
    'Wallet',
    'Approve',
    'Wait',
  ];

  var iconDates = <IconData>[
    Icons.money,
    Icons.fact_check,
    Icons.hourglass_bottom
  ];

  var bottonNavigationBarItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllWallet();
    setUpBottonBar();
  }

  Future<void> readAllWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idBuyer = preferences.getString('id');
    print('idBuyer ==> $idBuyer');

    var path =
        '${MyConstant.domain}/miniprojectmoblie/getWalletWhereidBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(path).then((value) {
      print('value ==> $value');
    });
  }

  void setUpBottonBar() {
    int index = 0;
    for (var element in titles) {
      bottonNavigationBarItems.add(
        BottomNavigationBarItem(
          label: element,
          icon: Icon(iconDates[index]),
        ),
      );
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[indexWidget],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: MyConstant.light,
        selectedItemColor: MyConstant.dark,
        onTap: (value) {
          setState(() {
            indexWidget = value;
          });
        },
        currentIndex: indexWidget,
        items: bottonNavigationBarItems,
      ),
    );
  }
}
