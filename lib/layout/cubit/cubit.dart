import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/models/categories_model.dart';
import 'package:shoping_app/models/change_favorite_model.dart';
import 'package:shoping_app/models/favorite_model.dart';
import 'package:shoping_app/models/home_model.dart';
import 'package:shoping_app/models/login_model.dart';
import 'package:shoping_app/moduls/categories_screen.dart';
import 'package:shoping_app/moduls/favorities_screen.dart';
import 'package:shoping_app/moduls/products_screen.dart';
import 'package:shoping_app/moduls/search_screen.dart';
import 'package:shoping_app/moduls/setting.dart';
import 'package:shoping_app/shared/components/constant.dart';
import 'package:shoping_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bootomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index ;
    emit(ShopChangeBottomNav());
  }

  HomeModel homeModel;
  Map<int, bool> favorities = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(uri: "home", token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorities.addAll({
          element.id : element.in_favorites
        });
      });
      print(favorities.toString());
      print(homeModel.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error);
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(uri: "categories", token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.status);
      emit(ShopCategoryState());
    }).catchError((error){
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoriteModel changeFavoriteModel;

  void changeFavorite(int product_id) {
    favorities[product_id] = !favorities[product_id];
    emit(ShopChangeFavoritiesState());

    DioHelper.postData(
            url: "favorites", data: {'product_id': product_id}, token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoriteModel.status){
        favorities[product_id] = !favorities[product_id];
      } else {
        getFavoriteModel();
      }
      emit(ShopSuccessFavoritiesState(changeFavoriteModel));
    }).catchError((error) {
      emit(ShopErrorFavoritiesState());
    });
  }

  FavoriteModel favoriteModel;

  void getFavoriteModel() {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(uri: "favorites", token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      print(favoriteModel.status);
      emit(ShopCategoryState());
    }).catchError((error){
      print(error);
      emit(ShopErrorCategoriesState());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      uri: "profile",
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel.status);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

}