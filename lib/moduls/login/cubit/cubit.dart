import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/models/login_model.dart';
import 'package:shoping_app/moduls/login/cubit/states.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userLogin({
   @required String email,
   @required String password,
}){
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: 'login',
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      print(value.data);
     loginModel = ShopLoginModel.fromJson(value.data);
     emit(ShopLoginSucessState(loginModel));
   }).catchError((error){
     print(error.toString());
     emit(ShopLoginErrorState(error.toString()));
   });
  }
}