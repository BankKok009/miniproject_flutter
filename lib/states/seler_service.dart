import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/bodys/shop_manage_seller.dart';
import 'package:my_mini_project/bodys/show_order_seller.dart';
import 'package:my_mini_project/bodys/show_product_seller.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_signout.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelerService extends StatefulWidget {
  const SelerService({super.key});

  @override
  State<SelerService> createState() => _SelerServiceState();
}

class _SelerServiceState extends State<SelerService> {
  List<Widget> widgets = [];
  int indexWidget = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    print('## id Login ==> $id');
    String apiGetUserWhereId =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      print('## value ==> $value');
      for (var element in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(element);
          widgets.add(const ShowOrderSeller());
          widgets.add(ShopManageSeller(userModel: userModel!));
          widgets.add(const ShowProductSeller());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: widgets.length == 0
          ? SizedBox()
          : Drawer(
              child: Stack(
                children: [
                  ShowSignOut(),
                  Column(
                    children: [
                      buildHead(),
                      menuShowOrder(),
                      menuShowShopManage(),
                      menuShowProduct(),
                    ],
                  ),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidget],
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
        otherAccountsPictures: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.face),
            iconSize: 36,
            color: MyConstant.light,
            tooltip: 'Edit Shop',
          )
        ],
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [MyConstant.light, MyConstant.dark],
            center: Alignment(-0.8, -0.2),
            radius: 1,
          ),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage:
              NetworkImage('${MyConstant.domain}${userModel?.avatar}'),
        ),
        accountName: Text(userModel == null ? 'Name ?' : userModel!.name),
        accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type));
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
