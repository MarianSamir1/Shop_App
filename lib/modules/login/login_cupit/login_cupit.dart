import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/login/login_cupit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCupit extends Cubit<ShopLoginState>{
  
  ShopLoginCupit() : super(ShopLoginInitialState()); 

  static ShopLoginCupit get(context) => BlocProvider.of(context);

  bool abscure = true;

  Icon abscureIcon = const Icon(Icons.visibility) ;

  void abscurefun(){
    abscure = !abscure;
    abscureIcon = abscure ? const Icon(Icons.visibility): const Icon(Icons.visibility_off);
    emit(ShopLoginChangeVisabilityState());
  }

 UserLoginModel? loginModel;

  void userLogin(
    {
      required String email,
      required String password
    }
  ){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN, 
      data: 
      {
        'email':email,
        'password':password 
      }).then((value) {
       loginModel = UserLoginModel.fromJson(value.data);
        print(loginModel!.status);
        print(loginModel!.message);
        emit(ShopLoginSuccessState(loginModel!));

      }).catchError((error){
        print('errorrrrrrrr ${error.toString()}');
        emit(ShopLoginErrorState(
          error.toString()
        ));
      });
  }

} 