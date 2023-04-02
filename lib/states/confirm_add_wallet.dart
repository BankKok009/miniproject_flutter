import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/show_image.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({super.key});

  @override
  State<ConfirmAddWallet> createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  String? dateTimeStr;
  File? file;
  var formKey = GlobalKey<FormState>();

  String? idBuyer;
  TextEditingController moneyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findCurrentTime();
    findIdBuyer();
  }

  Future<void> findIdBuyer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idBuyer = preferences.getString('id');
  }

  void findCurrentTime() async {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    setState(() {
      dateTimeStr = dateFormat.format(dateTime);
    });
    print('dateTimeStr = $dateTimeStr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Add Wallet'),
        leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, MyConstant.routeBuyerService, (route) => false),
            icon: Platform.isAndroid
                ? Icon(Icons.arrow_back)
                : Icon(Icons.arrow_back_ios)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newHeader(),
              newDateTimePay(),
              Spacer(),
              newMoney(),
              Spacer(),
              newImage(),
              Spacer(),
              newButtonConfirm()
            ],
          ),
        ),
      ),
    );
  }

  Row newMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: TextFormField(
            controller: moneyController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill Money ? ';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              label: ShowTitle(title: 'Money'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Container newButtonConfirm() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (file == null) {
              MyDialog().normalDialog(
                  context, 'ยังไม่มีรูปภาพ', 'กรุณา ภ่ายภาพหรือเลือกรูปภาพ');
            } else {
              processUploadAndInsertData();
            }
          }
        },
        child: Text('Confirm Add Wallet'),
      ),
    );
  }

  Future<void> processUploadAndInsertData() async {
    // upload Image to Server
    String apiSaveSlip = '${MyConstant.domain}/miniprojectmoblie/saveSlip.php';
    String nameSlip = 'slip${Random().nextInt(100000)}.jpg';

    print(apiSaveSlip);
    print(nameSlip);

    MyDialog().showProgressDialog(context);

    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameSlip);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveSlip, data: data).then((value) async {
        print('value => $value');
        Navigator.pop(context);

        // Insert value to mySQL
        var pathSlip = '/slip/$nameSlip';
        var status = 'WaitOrder';
        var urlAPIinsert =
            '${MyConstant.domain}/miniprojectmoblie/insertWallet.php?isAdd=true&idBuyer=$idBuyer&datePay=$dateTimeStr&money=${moneyController.text.trim()}&pathSlip=$pathSlip&status=$status';
        await Dio().get(urlAPIinsert).then(
              (value) => MyDialog(funcAction: success).actionDialog(
                context,
                'Confirm Success',
                'Confirm Add Money to Wallet Success',
              ),
            );
      });
    } catch (e) {}
  }

  void success() {
    Navigator.pushNamedAndRemoveUntil(
        context, MyConstant.routeBuyerService, (route) => false);
    print('Success Work');
  }

  Future<void> processTakePhoto(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row newImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () => processTakePhoto(ImageSource.camera),
          icon: Icon(Icons.add_a_photo),
        ),
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? ShowImage(path: 'images/bill2.png')
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => processTakePhoto(ImageSource.gallery),
          icon: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }

  ShowTitle newDateTimePay() {
    return ShowTitle(
      title: dateTimeStr == null ? 'dd/MM/yy HH:mm' : dateTimeStr!,
      textStyle: MyConstant().h2Style(),
    );
  }

  ShowTitle newHeader() {
    return ShowTitle(
      title: 'Current Date Pay',
      textStyle: MyConstant().h1Style(),
    );
  }
}
