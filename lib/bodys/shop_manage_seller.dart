import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class ShopManageSeller extends StatefulWidget {
  final UserModel userModel;
  const ShopManageSeller({super.key, required this.userModel});

  @override
  State<ShopManageSeller> createState() => _ShopManageSellerState();
}

class _ShopManageSellerState extends State<ShopManageSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  Future<Null> refreshuserModel() async {
    print('## refeshUserModel work');
    String apiGetUserWhereId =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereId.php?isAdd=true&id=${userModel!.id}';
    await Dio().get(apiGetUserWhereId).then((value) {
      for (var element in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(element);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyConstant.primary,
          child: Icon(Icons.edit),
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeEditProfileSaler)
                  .then((value) => refreshuserModel()),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowTitle(
                    title: 'Name Shop : ', textStyle: MyConstant().h2Style()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShowTitle(
                          title: userModel!.name,
                          textStyle: MyConstant().h1Style()),
                    ),
                  ],
                ),
                ShowTitle(
                    title: 'Address : ', textStyle: MyConstant().h2Style()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShowTitle(
                            title: userModel!.address,
                            textStyle: MyConstant().h2Style()),
                      ),
                    ),
                  ],
                ),
                ShowTitle(
                    title: 'Phone : ${userModel!.phone}',
                    textStyle: MyConstant().h2Style()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ShowTitle(
                      title: 'Avatar : ', textStyle: MyConstant().h2Style()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      child: CachedNetworkImage(
                        imageUrl: '${MyConstant.domain}${userModel!.avatar}',
                        placeholder: (context, url) => ShowProgress(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
