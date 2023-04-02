import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_mini_project/utility/my_constant.dart';
import 'package:my_mini_project/widgets/show_title.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTitle(),
          buildBKKbank(),
          buildKbank(),
        ],
      ),
    );
  }

  Widget buildBKKbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.indigo.shade300,
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/bbl.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกรุงเทพ สาขาบิ๊กซี บางนา',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นาย .. .. เลขบัญชี xxx - x - xxxxx - x',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKbank() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 150,
      child: Center(
        child: Card(
          color: Colors.green[100],
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('images/kbank.svg'),
              ),
            ),
            title: ShowTitle(
              title: 'ธนาคารกสิกรไทย สาขาบิ๊กซี บางนา',
              textStyle: MyConstant().h2Style(),
            ),
            subtitle: ShowTitle(
              title: 'ชื่อบัญชี นาง .. .. เลขบัญชี xxx - x - xxxxx - x',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
          title: 'การโอนเงินเข้า บัญชีธนาคาร',
          textStyle: MyConstant().h1Style()),
    );
  }
}
