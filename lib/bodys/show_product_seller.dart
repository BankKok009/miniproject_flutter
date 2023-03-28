import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/models/product_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({super.key});

  @override
  State<ShowProductSeller> createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;

    String apiGetProductWhereIdSeller =
        '${MyConstant.domain}/miniprojectmoblie/getProductWhereIdSeller.php?isAdd=true&idSeller=$id';
    await Dio().get(apiGetProductWhereIdSeller).then((value) {
      print('value ==> $value');
      for (var element in json.decode(value.data)) {
        ProductModel model = ProductModel.fromMap(element);
        print('name Product ==>> ${model.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is Show Product'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
        child: Text('Add'),
      ),
    );
  }
}
