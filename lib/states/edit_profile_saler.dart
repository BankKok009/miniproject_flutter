import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_mini_project/main.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileSaler extends StatefulWidget {
  const EditProfileSaler({super.key});

  @override
  State<EditProfileSaler> createState() => _EditProfileSalerState();
}

class _EditProfileSalerState extends State<EditProfileSaler> {
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user')!;

    String apiGetUser =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiGetUser).then((value) {
      print('value form API ==> $value');
      for (var element in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(element);
          nameController.text = userModel!.name;
          addressController.text = userModel!.address;
          phoneController.text = userModel!.phone;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit profile Seller'),
          actions: [
            IconButton(
              onPressed: () => processEditProfileSeller(),
              icon: Icon(Icons.edit),
              tooltip: 'Edit Profile Seller',
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  buildTitle('General : '),
                  buildName(constraints),
                  buildAddress(constraints),
                  buildPhone(constraints),
                  buildTitle('Avatar : '),
                  buildAvatar(constraints),
                  buildButtonEditProfile()
                ],
              ),
            ),
          ),
        ));
  }

  Future<Null> processEditProfileSeller() async {
    print('processEditProfileSeller work');

    MyDialog().showProgressDialog(context);

    if (formKey.currentState!.validate()) {
      if (file == null) {
        // user Current Avatar
        print('## User Current Avatar');
        editValueToMySQL(userModel!.avatar);
      } else {
        String apiSaveAvatar =
            '${MyConstant.domain}/miniprojectmoblie/saveAvatar.php';

        List<String> nameAvatars = userModel!.avatar.split('/');
        String nameFile = nameAvatars[nameAvatars.length - 1];
        nameFile = 'edit${Random().nextInt(100)}$nameFile';

        print('## User New Avatar namefile ==>> $nameFile');

        Map<String, dynamic> map = {};
        map['file'] =
            await MultipartFile.fromFile(file!.path, filename: nameFile);
        FormData formData = FormData.fromMap(map);
        await Dio().post(apiSaveAvatar, data: formData).then((value) {
          print('Upload Succes');
          String pathAvatar = '/miniprojectmoblie/avatar/$nameFile';
          editValueToMySQL(pathAvatar);
        });
      }
    }
  }

  Future<Null> editValueToMySQL(String pathAvatar) async {
    print('## pathAvatar ==> $pathAvatar');
    String apiEditProfile =
        '${MyConstant.domain}/miniprojectmoblie/editProfileSellerWhereId.php?isAdd=true&id=${userModel!.id}&name=${nameController.text}&address=${addressController.text}&phone=${phoneController.text}&avatar=$pathAvatar';
    await Dio().get(apiEditProfile).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  ElevatedButton buildButtonEditProfile() {
    return ElevatedButton.icon(
        onPressed: () => processEditProfileSeller(),
        icon: Icon(Icons.edit),
        label: Text('Edit Profile Seller'));
  }

  Future<Null> createAvatar({ImageSource? source}) async {
    try {
      var result = await ImagePicker().getImage(
        source: source!,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => createAvatar(source: ImageSource.camera),
                  icon: Icon(
                    Icons.add_a_photo,
                    color: MyConstant.dark,
                  )),
              Container(
                width: constraints.maxWidth * 0.6,
                height: constraints.maxWidth * 0.6,
                child: userModel == null
                    ? ShowProgress()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userModel!.avatar == null
                            ? ShowImage(path: MyConstant.avatar)
                            : file == null
                                ? buildShowImageNetwork()
                                : Image.file(file!),
                      ),
              ),
              IconButton(
                  onPressed: () => createAvatar(source: ImageSource.gallery),
                  icon:
                      Icon(Icons.add_photo_alternate, color: MyConstant.dark)),
            ],
          ),
        ),
      ],
    );
  }

  CachedNetworkImage buildShowImageNetwork() {
    return CachedNetworkImage(
      imageUrl: '${MyConstant.domain}${userModel!.avatar}',
      placeholder: (context, url) => ShowProgress(),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill Name';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill Address';
              } else {
                return null;
              }
            },
            maxLines: 3,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Address : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: constraints.maxWidth * 0.6,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill Phone';
              } else {
                return null;
              }
            },
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Phone : ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  ShowTitle buildTitle(String title) {
    return ShowTitle(
      title: title,
      textStyle: MyConstant().h2Style(),
    );
  }
}
