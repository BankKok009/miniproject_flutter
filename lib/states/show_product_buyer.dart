import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_mini_project/models/product_model.dart';
import 'package:my_mini_project/models/sqlite_model.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/utility/sqlite_helper.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class ShowProductBuyer extends StatefulWidget {
  final UserModel userModel;
  const ShowProductBuyer({super.key, required this.userModel});

  @override
  State<ShowProductBuyer> createState() => _ShowProductBuyerState();
}

class _ShowProductBuyerState extends State<ShowProductBuyer> {
  UserModel? userModel;
  bool load = true;
  bool haveProduct = false;
  List<ProductModel> productModel = [];
  List<List<String>> listImage = [];
  int indexImage = 0;
  int amountInt = 1;
  String? currentIdSeller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
    readAPI();
    readCart();
  }

  Future<Null> readCart() async {
    await SQLiteHelper().readSQLite().then((value) {
      print('### value readCart ==> ${value}');
      if (value.isNotEmpty) {
        List<SQLiteModel> models = [];
        for (var model in value) {
          models.add(model);
        }
        currentIdSeller = models[0].idSeller;
        print('### currentIdSeller = $currentIdSeller');
      }
    });
  }

  Future<void> readAPI() async {
    String urlAPI =
        '${MyConstant.domain}/miniprojectmoblie/getProductWhereIdSeller.php?isAdd=true&idSeller=${userModel!.id}';
    await Dio().get(urlAPI).then(
      (value) {
        // print('### value = ${value}');

        if (value.toString() == 'null') {
          setState(() {
            haveProduct = false;
            load = false;
          });
        } else {
          for (var element in json.decode(value.data)) {
            ProductModel model = ProductModel.fromMap(element);

            String string = model.images;
            string = string.substring(1, string.length - 1);
            List<String> strings = string.split(',');
            int i = 0;
            for (var element in strings) {
              strings[i] = element.trim();
              i++;
            }
            listImage.add(strings);

            setState(() {
              haveProduct = true;
              load = false;
              productModel.add(model);
            });
          }
        }
        setState(() {
          load = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel!.name),
      ),
      body: load
          ? ShowProgress()
          : haveProduct
              ? listProduct()
              : Center(
                  child: ShowTitle(
                      title: 'No Product', textStyle: MyConstant().h1Style()),
                ),
    );
  }

  LayoutBuilder listProduct() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        itemCount: productModel.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // print('### You Click index ==> ${index}');
            amountInt = 1;
            showAlertDialog(
              productModel[index],
              listImage[index],
            );
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  width: constraints.maxWidth * 0.5 - 8,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: findUrlImage(productModel[index].images),
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyConstant.image2),
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.5,
                  height: constraints.maxWidth * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShowTitle(
                          title: productModel[index].name,
                          textStyle: MyConstant().h2Style(),
                        ),
                        ShowTitle(
                          title: 'Price : ${productModel[index].price} THB',
                          textStyle: MyConstant().h3Style(),
                        ),
                        ShowTitle(
                          title:
                              cutWord('Detail : ${productModel[index].detail}'),
                          textStyle: MyConstant().h3Style(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String findUrlImage(String arrayImage) {
    String string = arrayImage.substring(1, arrayImage.length - 1);
    List<String> strings = string.split(',');
    int index = 0;
    for (var element in strings) {
      strings[index] = element.trim();
      index++;
    }
    String result = '${MyConstant.domain}/miniprojectmoblie${strings[0]}';
    // print('### result = ${result}');
    return result;
  }

  Future<Null> showAlertDialog(
      ProductModel productModel, List<String> images) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: ListTile(
                  leading: ShowImage(
                    path: MyConstant.image2,
                  ),
                  title: ShowTitle(
                      title: productModel.name,
                      textStyle: MyConstant().h2Style()),
                  subtitle: ShowTitle(
                      title: 'Price : ${productModel.price} THB',
                      textStyle: MyConstant().h3Style()),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${MyConstant.domain}/miniprojectmoblie${images[indexImage]}',
                        placeholder: (context, url) => ShowProgress(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 0;
                                  // print('### indexImage = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_1),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 1;
                                  // print('### indexImage = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_2),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 2;
                                  // print('### indexImage = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_3),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  indexImage = 3;
                                  // print('### indexImage = $indexImage');
                                });
                              },
                              icon: Icon(Icons.filter_4),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ShowTitle(
                              title: 'รายละเอียด : ',
                              textStyle: MyConstant().h2Style()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: ShowTitle(
                                  title: productModel.detail,
                                  textStyle: MyConstant().h3Style()),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (amountInt != 1) {
                                  setState(() {
                                    amountInt--;
                                  });
                                }
                              },
                              icon: Icon(Icons.remove_circle_outline)),
                          ShowTitle(
                              title: amountInt.toString(),
                              textStyle: MyConstant().h1Style()),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  amountInt++;
                                });
                              },
                              icon: Icon(Icons.add_circle_outline)),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async {
                          String idSeller = userModel!.id;
                          String idProduct = productModel.id;
                          String name = productModel.name;
                          String price = productModel.price;
                          String amount = amountInt.toString();
                          int sumInt = int.parse(price) * amountInt;
                          String sum = sumInt.toString();
                          print(
                              '### idSeller ==> ${idSeller}, idProduct ==> ${idProduct}, name = ${name}, price = ${price}, amount = ${amount}, total = ${sum}');

                          if (currentIdSeller == idSeller ||
                              currentIdSeller == null) {
                            SQLiteModel sqLiteModel = SQLiteModel(
                                idSeller: idSeller,
                                idProduct: idProduct,
                                name: name,
                                price: price,
                                amount: amount,
                                sum: sum);
                            await SQLiteHelper()
                                .insertValueToSQLite(sqLiteModel)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            MyDialog().normalDialog(context, 'ร้านผิด ?',
                                'กรุณาเลือกสินค้าที่ร้าน ${productModel.name} ให้เสร็จก่อน เลือกร้านอื่นครับ');
                          }
                        },
                        child: ShowTitle(
                            title: 'Add to Cart',
                            textStyle: MyConstant().h2BlueStyle()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: ShowTitle(
                            title: 'Cancel',
                            textStyle: MyConstant().h2RedStyle()),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  String cutWord(String string) {
    String result = string;
    if (result.length > 150) {
      result = result.substring(0, 150);
      result = '${result} ...';
    }
    return result;
  }
}
