import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_mini_project/models/user_model.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: Container(
              decoration: MyConstant().planBackground(),
              child: ListView(
                children: [
                  buildImage(size),
                  buildAppName(),
                  buildUser(size),
                  buildPassword(size),
                  buildLogin(size),
                  buildCreateAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          textStyle: MyConstant().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: ShowTitle(
            title: 'Create Acount',
          ),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String user = userController.text;
                String password = passwordController.text;
                print('## user = $user, password = $password');
                checkAuthen(user: user, password: password);
              }
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }

  Future<Null> checkAuthen({String? user, String? password}) async {
    String apiCheckAuthen =
        '${MyConstant.domain}/miniprojectmoblie/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckAuthen).then((value) async {
      print('## value for API ==>> $value');
      if (value.toString() == 'null') {
        MyDialog().normalDialog(
            context, 'User Faluse !!!', 'No $user in my Database');
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            // Success Authen
            String type = model.type;
            print('## Authen Success in Type ==> $type');

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('id', model.id);
            preferences.setString('type', type);
            preferences.setString('user', model.user);
            preferences.setString('name', model.name);

            switch (type) {
              case 'buyer':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeBuyerService, (route) => false);
                break;
              case 'seller':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeSelerService, (route) => false);
                break;
              case 'rider':
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.routeRiderService, (route) => false);
                break;
              default:
            }
          } else {
            // Authen Flase
            MyDialog().normalDialog(context, 'Password False !!!',
                'Password False Please Try Again');
          }
        }
      }
    });
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
                return 'Please Fill User in Blank';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.75),
              labelStyle: MyConstant().h3Style(),
              labelText: 'User : ',
              prefixIcon: Icon(
                Icons.account_circle_outlined,
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
                return 'Please Fill Password in Blank';
              } else {
                return null;
              }
            },
            obscureText: statusRedEye,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.75),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                        color: MyConstant.dark,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dark,
                      ),
              ),
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

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1Style(),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: ShowImage(path: MyConstant.image1),
        ),
      ],
    );
  }
}
