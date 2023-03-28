import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'Shopping Com';
  static String domain = 'https://9e57-171-6-107-22.ap.ngrok.io';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSelerService = '/selerService';
  static String routeRiderService = '/riderService';
  static String routeAddProduct = '/addProduct';

  // Image
  static String image1 = 'images/posterShopping1.png';
  static String image2 = 'images/posterShopping2.png';
  static String image3 = 'images/posterShopping3.png';
  static String image4 = 'images/posterShopping4.png';
  static String avatar = 'images/avatar.png';
  static String imageIcon = 'images/imageIcon.png';

  //
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 191, 228, 0.1),
    100: Color.fromRGBO(255, 191, 228, 0.2),
    200: Color.fromRGBO(255, 191, 228, 0.3),
    300: Color.fromRGBO(255, 191, 228, 0.4),
    400: Color.fromRGBO(255, 191, 228, 0.5),
    500: Color.fromRGBO(255, 191, 228, 0.6),
    600: Color.fromRGBO(255, 191, 228, 0.7),
    700: Color.fromRGBO(255, 191, 228, 0.8),
    800: Color.fromRGBO(255, 191, 228, 0.9),
    900: Color.fromRGBO(255, 191, 228, 1.0),
  };

  // Color
  static Color primary = Color(0xff83e46a);
  static Color dark = Color(0xffbfe46a);
  static Color light = Color(0xff6ae48f);

  // Style
  // ตัวใหญ่
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  // หัวข้อ
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  // body ธรรมดา
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
