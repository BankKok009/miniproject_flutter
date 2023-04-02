// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:my_mini_project/states/add_product.dart';
import 'package:my_mini_project/states/add_wallet.dart';
import 'package:my_mini_project/states/authen.dart';
import 'package:my_mini_project/states/buyer_service.dart';
import 'package:my_mini_project/states/create_account.dart';
import 'package:my_mini_project/states/edit_profile_saler.dart';
import 'package:my_mini_project/states/rider_service.dart';
import 'package:my_mini_project/states/seler_service.dart';
import 'package:my_mini_project/states/show_cart.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/selerService': (BuildContext context) => SelerService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfileSaler': (BuildContext context) => EditProfileSaler(),
  '/showCart': (BuildContext context) => ShowCart(),
  '/addWallet': (BuildContext context) => AddWallet(),
};

String? initlalRounte;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final String? type = preferences.getString('type');
  print('#### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRounte = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlalRounte = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initlalRounte = MyConstant.routeSelerService;
        runApp(MyApp());
        break;
      case 'rider':
        initlalRounte = MyConstant.routeRiderService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xffbfe46a, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRounte,
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
