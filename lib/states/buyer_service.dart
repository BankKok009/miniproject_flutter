import 'package:flutter/material.dart';
import 'package:my_mini_project/bodys/my_money_buyer.dart';
import 'package:my_mini_project/bodys/my_order_buyer.dart';
import 'package:my_mini_project/bodys/show_all_shop_buyer.dart';
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
  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MyConstant.routeShowCart),
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'Show All Shop',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงร้านค้าทั้งหมด',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.money,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'MyMoney',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงจำนวนเงินที่มี',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'My Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งของของฉัน',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
