import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/shop_layout_screen.dart';
import 'package:shoping_app/shared/network/local/cache_helper.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';
import 'moduls/login/login_shop_screen.dart';
import 'moduls/on_board_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.init();

  Widget widget;
  bool onBoard = CasheHelper.getData(key:'onBoarding');
  String token = CasheHelper.getData(key:'token');
  token = CasheHelper.getData(key: 'token');
  print(token);


  if(onBoard != null)
  {
    if(token != null){
      widget = ShopLayoutScreen();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardScreen();
  }



  print(onBoard);
  runApp(MyApp(ShopLayoutScreen()));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteModel()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}
