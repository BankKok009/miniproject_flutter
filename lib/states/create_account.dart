// import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  String avatar = '';
  File? file;
  // double? lat, lng;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkPermission();
  // }

  // Future<Null> checkPermission() async {
  //   bool locationService;
  //   LocationPermission locationPermission;

  //   locationService = await Geolocator.isLocationServiceEnabled();
  //   if (locationService) {
  //     print('Service Location Open');

  //     locationPermission = await Geolocator.checkPermission();
  //     if (locationPermission == LocationPermission.denied) {
  //       locationPermission = await Geolocator.requestPermission();
  //       if (locationPermission == LocationPermission.deniedForever) {
  //         MyDialog().alertLocationService(
  //             context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
  //       } else {
  //         // find LatLang
  //         findLatLng();
  //       }
  //     } else {
  //       if (locationPermission == LocationPermission.deniedForever) {
  //         MyDialog().alertLocationService(
  //             context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
  //       } else {
  //         //find LatLog
  //         findLatLng();
  //       }
  //     }
  //   } else {
  //     print('Serivce Location Close');
  //     MyDialog().alertLocationService(context, 'Location Service ปิดอยู่ ?',
  //         'กรุณาเปิด Location Service ด้วยครับ');
  //   }
  // }

  // Future<Null> findLatLng() async {
  //   print('find LatLng ===> Work');
  //   Position? position = await findPostion();
  //   setState(() {
  //     lat = position!.latitude;
  //     lng = position.longitude;
  //     print('lat = $lat, lng = $lng');
  //   });
  // }

  // Future<Position?> findPostion() async {
  //   Position position;
  //   try {
  //     position = await Geolocator.getCurrentPosition();
  //     return position;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่กรอก Name ด้วยครับ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Name : ',
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่กรอก Phone ด้วยครับ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Phone : ',
              prefixIcon: Icon(
                Icons.phone_android,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่กรอก User ด้วยครับ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'User : ',
              prefixIcon: Icon(
                Icons.perm_identity,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่กรอก Password ด้วยครับ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'Password : ',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาใส่กรอก Address ด้วยครับ';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Address : ',
              hintStyle: MyConstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dark,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [buildCreateNewAccount()],
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle('ข้อมูลทั่วไป'),
                buildName(size),
                buildTitle('ชนิดของ User : '),
                buildRadioBuyer(size),
                buildRadioSeller(size),
                buildRadioRider(size),
                buildTitle('ข้อมูลพื้นฐาน'),
                buildAddress(size),
                buildPhone(size),
                buildUser(size),
                buildPassword(size),
                buildTitle('รูปภาพ'),
                buildSubTitle(),
                buildAvatar(size),
                // buildTitle('แสดงพิกัดที่คุณอยู่'),
                // buildMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose Type user');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือก ชนิดของ User',
                'กรุณาเลือกที่ชนิด User ที่ต้องการ');
          } else {
            print('Process Insert to Datebase');
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> uploadPictureAndInsertData() async {
    String name = nameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    String user = userController.text;
    String password = passwordController.text;
    print(
        '## name = $name, address = $address, phone = $phone, user = $user, password = $password');
    String path =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print('## value ==>> $value');
      print(path);
      if (value.toString() == 'null') {
        print('## user OK');

        if (file == null) {
          // No Avatar
          processInsertMySQL(
            name: name,
            address: address,
            phone: phone,
            user: user,
            password: password,
          );
        } else {
          // Have Avatar
          print('### process Upload Avatar');
          String apiSaveAvatar =
              '${MyConstant.domain}/miniprojectmoblie/saveAvatar.php';
          int i = Random().nextInt(100000);
          String nameAvatar = 'avatar$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] = await MultipartFile.fromFile(
            file!.path,
            filename: nameAvatar,
          );
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveAvatar, data: data).then(
            (value) {
              avatar = '/miniprojectmoblie/avatar/$nameAvatar';
              processInsertMySQL(
                name: name,
                address: address,
                phone: phone,
                user: user,
                password: password,
                avatar: avatar,
              );
            },
          );
        }
      } else {
        MyDialog().normalDialog(context, 'User false ?', 'Please Change User');
      }
    });
  }

  Future<Null> processInsertMySQL({
    String? name,
    String? address,
    String? phone,
    String? user,
    String? password,
    String? avatar,
  }) async {
    print('### processInsertMySQL Work and avatar ==>> $avatar');
    String apiInsertUser =
        '${MyConstant.domain}/miniprojectmoblie/insertUser.php?isAdd=true&name=$name&type=$typeUser&address=$address&phone=$phone&user=$user&password=$password&avatar=$avatar';
    await Dio().get(apiInsertUser).then((value) => {
          if (value.toString() == 'true')
            {
              Navigator.pop(context),
            }
          else
            {
              MyDialog().normalDialog(
                  context, 'Create New User Flase !!!', 'Please Try Again.')
            }
        });
  }

  // Widget buildMap() => Container(
  //       width: double.infinity,
  //       height: 200,
  //       child: lat == Null ? ShowProgress() : Text('Lat = $lat, Lng = $lng'),
  //     );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.5,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
        title:
            'เป็นรูปภาพ ที่แสดงความเป็นตัวตนของ User (แต่ถ้าไม่สะดวกแชร์ เราจะแสดงภาพ default)',
        textStyle: MyConstant().h3Style());
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ (Buyer)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย (Seller)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value;
              });
            },
            title: ShowTitle(
              title: 'ผู้ส่ง (Rider)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
