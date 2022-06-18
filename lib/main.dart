import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/chash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styels/constants.dart';
import 'package:shop_app/shared/styels/themes.dart';
import 'modules/menu/zoom_drawer/drawer.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //عشان امنع ان الموبيل يتقلب
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  Bloc.observer = MyBlocObserver();

  await ChashHelper.init();

  DioHelper.init();

  Widget widget;

  bool? onBoarding = ChashHelper.getData(key: 'onBoarding');

  token = ChashHelper.getData(key: 'token');

  if(onBoarding != null){
    if(token != null) {
      widget = const DrawerScreen();
    } else {
      widget = const LoginScreen();
    }
  }else{
    widget = OnBoardingScreen();
  }
  
  //bool? fromShared = ChashHelper().getBoolData( key: 'isDark');
  HttpOverrides.global= MyHttpOverrides();
  runApp( MyApp(
    widget: widget,
  ));
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget widget;
   MyApp({required this.widget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopLayoutCubit()..getCartData()
    ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        // darkTheme: darkTheme(),
        home: widget,
      ),
    );
  }
}