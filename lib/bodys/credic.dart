import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/show_title.dart';
import 'package:omise_flutter/omise_flutter.dart';

class Credic extends StatefulWidget {
  const Credic({super.key});

  @override
  State<Credic> createState() => _CredicState();
}

class _CredicState extends State<Credic> {
  String? name,
      surname,
      idCard,
      expiryDateMouth,
      expiryDateYear,
      cvc,
      amount,
      expriyDateStr;
  MaskTextInputFormatter idCardMask =
      MaskTextInputFormatter(mask: '#### - #### - #### - ####');
  MaskTextInputFormatter expiryDateMask =
      MaskTextInputFormatter(mask: '## / ####');
  MaskTextInputFormatter cvcMask = MaskTextInputFormatter(mask: '###');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('Name Surname'),
                    buildNameSurname(),
                    buildTitle('ID Card'),
                    formIDcard(),
                    buildExpiryCVC(),
                    buildTitle('Amount : '),
                    formAmount(),
                    // Spacer(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buttonAddMoney(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buttonAddMoney() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            getTokenAndChargeOmise();
          }
        },
        child: Text('Add Money'),
      ),
    );
  }

  Future<void> getTokenAndChargeOmise() async {
    String publickey = MyConstant.publicKey;

    print(
        'publicKey = $publickey, idCard ==> $idCard, exprityDataStr = $expriyDateStr, expiryDateMouth ==> $expiryDateMouth, expiryDateYear ==> $expiryDateYear, cvc ==> $cvc');

    OmiseFlutter omiseFlutter = OmiseFlutter(publickey);
    await omiseFlutter.token
        .create(
            '$name $surname', idCard!, expiryDateMouth!, expiryDateYear!, cvc!)
        .then((value) {
      String token = value.id.toString();
      print('token ==> $token');

      String secretkey = MyConstant.secretKey;
      String urlAPI = '';
    }).catchError((value) {
      String title = value.code;
      String message = value.message;
      MyDialog().normalDialog(context, title, message);
    });
  }

  Widget formAmount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill Amount in Blank';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffix: ShowTitle(
              title: 'THB.',
              textStyle: MyConstant().h2Style(),
            ),
            label: ShowTitle(title: 'Amount : '),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Container buildExpiryCVC() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizebox(30),
          Expanded(
              child: Column(
            children: [
              buildTitle('Expiry Date : '),
              formExpriyDate(),
            ],
          )),
          buildSizebox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC : '),
                formCVC(),
              ],
            ),
          ),
          buildSizebox(30),
        ],
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizebox(30),
          formName(),
          buildSizebox(8),
          formSurname(),
          buildSizebox(30),
        ],
      ),
    );
  }

  SizedBox buildSizebox(double width) => SizedBox(
        width: width,
      );

  Widget formIDcard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill ID Card in Blank';
            } else {
              if (idCard!.length != 16) {
                return 'ID Card ต้องมี 16 ตัวอักษร';
              } else {
                return null;
              }
            }
          },
          inputFormatters: [idCardMask],
          onChanged: (value) {
            // idCard = value.trim();
            idCard = idCardMask.getUnmaskedText();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'xxxx-xxxx-xxxx-xxxx',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Widget formExpriyDate() => TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Expiry Date in Blank';
          } else {
            if (expriyDateStr!.length != 6) {
              return 'กรุณากรอกให้ครบ';
            } else {
              expiryDateMouth = expriyDateStr!.substring(0, 2);
              expiryDateYear = expriyDateStr!.substring(2, 6);

              int expiryDateMouthInt = int.parse(expiryDateMouth!);
              expiryDateMouth = expiryDateMouthInt.toString();

              if (expiryDateMouthInt > 12) {
                return 'เดือนไม่ควรเกิน 12 เดือน';
              } else {
                return null;
              }
            }
          }
        },
        onChanged: (value) {
          expriyDateStr = expiryDateMask.getUnmaskedText();
        },
        inputFormatters: [expiryDateMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xx/xxxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  Widget formCVC() => TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill CVC in Blank';
          } else {
            if (cvc!.length != 3) {
              return 'cvc ต้องมี 3 ตัว';
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {
          cvc = cvcMask.getUnmaskedText();
        },
        inputFormatters: [cvcMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  Widget formName() => Expanded(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill Name in Blank';
            } else {
              name = value.trim();
              return null;
            }
          },
          decoration: InputDecoration(
            label: ShowTitle(title: 'Name : '),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Widget formSurname() => Expanded(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill Surname in Blank';
            } else {
              surname = value.trim();
              return null;
            }
          },
          decoration: InputDecoration(
            label: ShowTitle(title: 'Surname : '),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Widget buildTitle(String title) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShowTitle(
          title: title,
          textStyle: MyConstant().h2Style(),
        ),
      );
}
