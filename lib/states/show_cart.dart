import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/models/sqlite_model.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/sqlite_helper.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class ShowCart extends StatefulWidget {
  const ShowCart({super.key});

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = [];
  bool load = true;
  UserModel? userModel;
  int? total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processReadSQLite();
  }

  Future<Null> processReadSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
    }

    await SQLiteHelper().readSQLite().then((value) {
      setState(() {
        load = false;
        sqliteModels = value;
        findDetailSeller();
        calculateTotal();
      });
    });
  }

  void calculateTotal() async {
    total = 0;
    for (var element in sqliteModels) {
      int sumInt = int.parse(element.sum.trim());
      setState(() {
        total = total! + sumInt;
      });
    }
  }

  Future<void> findDetailSeller() async {
    String idSeller = sqliteModels[0].idSeller;
    String apiGetUserWhereId =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereId.php?isAdd=true&id=$idSeller';
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
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
      body: load
          ? ShowProgress()
          : sqliteModels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        width: 200,
                        child: ShowImage(path: MyConstant.image2),
                      ),
                      ShowTitle(
                          title: 'Empty Cart',
                          textStyle: MyConstant().h2Style()),
                    ],
                  ),
                )
              : buildContent(),
    );
  }

  Column buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showSeller(),
        buildHead(),
        listProduct(),
        buildDivider(),
        buildTotal(),
        buildDivider(),
        buttonContorller(),
      ],
    );
  }

  Future<void> confirmEmptyCart() async {
    print('### confirmEmptyCart work');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image2),
          title: ShowTitle(
            title: 'คุณต้องการจะลบ ?',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
              title: 'Product ทั้งหมดในตระกร้า ?',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await SQLiteHelper().emptySQLite().then((value) {
                Navigator.pop(context);
                processReadSQLite();
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Row buttonContorller() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Order'),
        ),
        Container(
          margin: EdgeInsets.only(left: 4, right: 8),
          child: ElevatedButton(
            onPressed: () => confirmEmptyCart(),
            child: Text('Empty Cart'),
          ),
        ),
      ],
    );
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Total : ',
                textStyle: MyConstant().h2Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: total == null ? '' : total.toString(),
                textStyle: MyConstant().h1Style(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Divider buildDivider() {
    return Divider(
      color: MyConstant.dark,
    );
  }

  ListView listProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ShowTitle(
                title: sqliteModels[index].name,
                textStyle: MyConstant().h3Style(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].price,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].amount,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: ShowTitle(
              title: sqliteModels[index].sum,
              textStyle: MyConstant().h3Style(),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                int? idSQLite = sqliteModels[index].id;
                print('### You Click Delete ${idSQLite}');
                await SQLiteHelper()
                    .deleteSQLiteWhereId(idSQLite!)
                    .then((value) => processReadSQLite());
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHead() {
    return Container(
      decoration: BoxDecoration(color: MyConstant.light),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ShowTitle(
                  title: 'Product',
                  textStyle: MyConstant().h2Style(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Price',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Amount',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Total',
                textStyle: MyConstant().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Padding showSeller() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: userModel == null ? '' : userModel!.name,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }
}
