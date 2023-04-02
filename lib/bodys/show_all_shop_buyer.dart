import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/states/show_product_buyer.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class ShowAllShopBuyer extends StatefulWidget {
  const ShowAllShopBuyer({super.key});

  @override
  State<ShowAllShopBuyer> createState() => _ShowAllShopBuyerState();
}

class _ShowAllShopBuyerState extends State<ShowAllShopBuyer> {
  bool load = true;
  List<UserModel> userModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlAPI =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereSeller.php';
    await Dio().get(urlAPI).then((value) {
      setState(() {
        load = false;
      });
      // print('value ===> $value');
      var result = json.decode(value.data);
      // print('result ===> $result');
      for (var element in result) {
        // print('element ==> $element');
        UserModel model = UserModel.fromMap(element);
        // print('name ==> ${model.name}');
        setState(() {
          userModel.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : Container(
              decoration: MyConstant().planBackground(),
              child: GridView.builder(
                itemCount: userModel.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 2 / 3, maxCrossAxisExtent: 160),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    // print('You Click form ${userModel[index].id}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowProductBuyer(userModel: userModel[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    ShowImage(path: MyConstant.avatar),
                                placeholder: (context, url) => ShowProgress(),
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${MyConstant.domain}${userModel[index].avatar}'),
                          ),
                          ShowTitle(
                            title: cutWord(userModel[index].name),
                            textStyle: MyConstant().h2Style(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  String cutWord(String name) {
    String result = name;
    if (result.length > 14) {
      result = result.substring(0, 10);
      result = '$result ...';
    }
    return result;
  }
}
