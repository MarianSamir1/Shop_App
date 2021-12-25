import 'package:shop_app/models/cart_models/add_to_cart_model.dart';
import 'package:shop_app/models/user_model.dart';

abstract class ShopLayoutState {}

class ShopLayoutInitialState extends ShopLayoutState{}

class ShopBottomNavChangeState extends ShopLayoutState{}

class ShopLayoutHomeDataLoadingState extends ShopLayoutState{}

class ShopLayoutHomeDataSuccessState extends ShopLayoutState{}

class ShopLayoutHomeDataErrorState extends ShopLayoutState{
  final String error;

   ShopLayoutHomeDataErrorState(this.error);
}

class ShopGetProductsDetailsSuccessState extends ShopLayoutState{}

class ShopGetProductsDetailsErrorState extends ShopLayoutState{
  final String error;

   ShopGetProductsDetailsErrorState(this.error);
}

class ShopGetProductsDetailsLoadingState extends ShopLayoutState{}

class ShopLayoutChangeFavSuccessState extends ShopLayoutState{}

class ShopLayoutChangeFavErrorState extends ShopLayoutState{
  final String error;

   ShopLayoutChangeFavErrorState(this.error);
}

class ShopLayoutChangeFavState extends ShopLayoutState{}

class ShopCategoriesSuccessState extends ShopLayoutState{}

class ShopCategoriesErrorState extends ShopLayoutState{
  final String error;

   ShopCategoriesErrorState(this.error);
}

class ShopGetCategoriesDetailsSuccessState extends ShopLayoutState{}

class ShopGetCategoriesDetailsErrorState extends ShopLayoutState{
  final String error;

   ShopGetCategoriesDetailsErrorState(this.error);
}

class ShopGetCategoriesDetailsLoadingState extends ShopLayoutState{}

class ShopGetFavorietsSuccessState extends ShopLayoutState{}

class ShopGetFavorietsErrorsState extends ShopLayoutState{
  final String error;

   ShopGetFavorietsErrorsState(this.error);
}

class ShopGetFavorietsLoadingState extends ShopLayoutState{}

class ShopGetUserDataLoadingState extends ShopLayoutState{}

class ShopGetUserDataSuccessState extends ShopLayoutState{}

class ShopGetUserDataErrorState extends ShopLayoutState{
  final String error;

  ShopGetUserDataErrorState(this.error);

   
}

class ShopUpdateProfileLoadingState extends ShopLayoutState{}

class ShopUpdateProfileDataSuccessState extends ShopLayoutState{
 UserLoginModel userData;

  ShopUpdateProfileDataSuccessState(this.userData);

  
}

class ShopUpdateProfileDataErrorState extends ShopLayoutState{
  final String error;

  ShopUpdateProfileDataErrorState(this.error);

   
}

class ShopGetCartDataLoadingState extends ShopLayoutState{}

class ShopGetCartDataSuccessState extends ShopLayoutState{}

class ShopGetCartDataErrorState extends ShopLayoutState{
  final String error;

  ShopGetCartDataErrorState(this.error);

   
}

class ShopAddOrRemoveCartDataLoadingState extends ShopLayoutState{}

class ShopAddOrRemoveCartDataSuccessState extends ShopLayoutState{
  AddOrRemoveToCartModel addOrRemoveToCartModel;
  ShopAddOrRemoveCartDataSuccessState(this.addOrRemoveToCartModel);
}

class ShopAddOrRemoveCartDataErrorState extends ShopLayoutState{
  final String error;

  ShopAddOrRemoveCartDataErrorState(this.error);

   
}

class BlusState extends ShopLayoutState{}

class MinusState extends ShopLayoutState{}

class SearchLoadingState extends ShopLayoutState{}

class SearchSuccessState extends ShopLayoutState{}

class SearchErrorState extends ShopLayoutState{
  final String error;

  SearchErrorState(this.error);

}
