import 'package:shoping_app/models/change_favorite_model.dart';
import 'package:shoping_app/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNav extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopCategoryState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoritiesState extends ShopStates{}

class ShopSuccessFavoritiesState extends ShopStates{
  final ChangeFavoriteModel model;

  ShopSuccessFavoritiesState(this.model);
}

class ShopErrorFavoritiesState extends ShopStates{}

class ShopLoadingGetFavoriteState extends ShopStates{}

class ShopSuccessGetFavoriteState extends ShopStates{}

class ShopErrorGetFavoriteState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel uselModel;

  ShopSuccessUserDataState(this.uselModel);
}

class ShopErrorUserDataState extends ShopStates{}
