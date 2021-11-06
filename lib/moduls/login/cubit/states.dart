import 'package:shoping_app/models/login_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSucessState extends ShopLoginState{
  final ShopLoginModel loginModel;

  ShopLoginSucessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);

}

