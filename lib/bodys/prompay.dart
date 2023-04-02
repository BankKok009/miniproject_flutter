import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/utility/my_dialog.dart';
import 'package:my_mini_project/widgets/nav_confirm_add_wallet.dart';
import 'package:my_mini_project/widgets/show_progress.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class Prompay extends StatefulWidget {
  const Prompay({super.key});

  @override
  State<Prompay> createState() => _PrompayState();
}

class _PrompayState extends State<Prompay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPrompay(),
            buildQRcodePrompay(),
            buildDownloadQRcode()
          ],
        ),
      ),
      floatingActionButton: NavConfirmAddWallet(),
    );
  }

  ElevatedButton buildDownloadQRcode() => ElevatedButton(
        onPressed: () async {
          //https://promptpay.io/0987654321.png
        },
        child: Text('Download QRcode'),
      );

  Container buildQRcodePrompay() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: MyConstant.urlPrompay,
        placeholder: (context, url) => ShowProgress(),
      ),
    );
  }

  Widget buildCopyPrompay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.lime.shade100,
        child: ListTile(
          title: ShowTitle(
            title: '098 765 4321',
            textStyle: MyConstant().h1Style(),
          ),
          subtitle: ShowTitle(title: 'บัญชี Prompay'),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: '0987654321'),
              );
              MyDialog().normalDialog(context, 'Copy Prompay',
                  'Copy Prompay to Clipboard สำเร็วแล้ว.. กรุณานำไปที่แอพธนาคารของท่านเพื่อโอนงานผ่าน Prompay');
            },
            icon: Icon(
              Icons.copy,
              color: MyConstant.dark,
            ),
          ),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
      title: 'การโอนเงินโดนใช้ Prompay',
      textStyle: MyConstant().h2Style(),
    );
  }
}
