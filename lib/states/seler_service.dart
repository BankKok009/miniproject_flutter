import 'package:flutter/material.dart';
import 'package:my_mini_project/bodys/shop_manage_seller.dart';
import 'package:my_mini_project/bodys/show_order_seller.dart';
import 'package:my_mini_project/bodys/show_product_seller.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_signout.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class SelerService extends StatefulWidget {
  const SelerService({super.key});

  @override
  State<SelerService> createState() => _SelerServiceState();
}

class _SelerServiceState extends State<SelerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShopManageSeller(),
    ShowProductSeller(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShowShopManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Your Order',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของ Order ที่สั่ง',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Shop Manage',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของ หน้าร้านที่ให้ลูกค้าเห็น',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายละเอียดของ สินค้าที่ขาย',
        textStyle: MyConstant().h3Style(),
      ),
    );
  }
}
