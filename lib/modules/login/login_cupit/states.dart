import 'package:shop_app/models/user_model.dart';

abstract class ShopLoginState{}

class ShopLoginInitialState extends ShopLoginState{}

class ShopLoginLoadingState extends ShopLoginState{}

class ShopLoginSuccessState extends ShopLoginState{
 final UserLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState{
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangeVisabilityState extends ShopLoginState{}