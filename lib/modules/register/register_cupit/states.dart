import 'package:shop_app/models/user_model.dart';

abstract class ShopRegisterState{}

class ShopRegisterInitialState extends ShopRegisterState{}

class ShopRegisterLoadingState extends ShopRegisterState{}

class ShopRegisterSuccessState extends ShopRegisterState{
 final UserLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterErrorState extends ShopRegisterState{
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangeVisabilityState extends ShopRegisterState{}