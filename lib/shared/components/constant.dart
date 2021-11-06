import 'package:flutter/material.dart';
import 'package:shoping_app/moduls/login/login_shop_screen.dart';
import 'package:shoping_app/shared/network/local/cache_helper.dart';

String token = '';

void singOut(BuildContext context){
  CasheHelper.clearData(key: 'token')
      .then((value)
  {
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShopLoginScreen()),
              (route) => false
      );
    }
  });
}