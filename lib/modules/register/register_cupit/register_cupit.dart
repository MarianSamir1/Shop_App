import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/register/register_cupit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCupit extends Cubit<ShopRegisterState>{
  
  ShopRegisterCupit() : super(ShopRegisterInitialState()); 

  static ShopRegisterCupit get(context) => BlocProvider.of(context);

  bool abscure = true;

  Icon abscureIcon = const Icon(Icons.visibility) ;

  void abscurefun(){
    abscure = !abscure;
    abscureIcon = abscure ? const Icon(Icons.visibility): const Icon(Icons.visibility_off);
    emit(ShopRegisterChangeVisabilityState());
  }

 UserLoginModel? registerModel;

  void userRegister(
    {
      required String name,
      required String phone,
      required String email,
      required String password
    }
  ){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER, 
      data: 
      {
        'name': name,
        'phone': phone,
        'email':email,
        'password':password 
      }).then((value) {
       registerModel = UserLoginModel.fromJson(value.data);
        print(registerModel!.status);
        print(registerModel!.message);
        emit(ShopRegisterSuccessState(registerModel!));

      }).catchError((error){
        print(error.toString());
        emit(ShopRegisterErrorState(
          error.toString()
        ));
      });
  }

} 