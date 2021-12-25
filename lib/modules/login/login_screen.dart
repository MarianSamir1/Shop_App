import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login_cupit/login_cupit.dart';
import 'package:shop_app/modules/login/login_cupit/states.dart';
import 'package:shop_app/modules/menu/zoom_drawer/drawer.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/chash_helper.dart';
import 'package:shop_app/shared/styels/constants.dart';


class LoginScreen extends StatefulWidget {


  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

    late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopLoginCupit(),
      child: BlocConsumer<ShopLoginCupit,ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status){
              fToast.showToast(
                  child: showToastWithIcon(
                    msg: state.loginModel.message,
                  ),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
              ChashHelper.saveData(
                key: 'token', 
                value: state.loginModel.data!.token
                ).then((value) {
                  if(value){
                    token = ChashHelper.getData(key: 'token');
                    Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context)=> const DrawerScreen()));
                  }
              });
            }else{
            
              showToast(msg: state.loginModel.message, state: ToastStates.ERROR);
            }
          }else if(state is ShopLoginErrorState){
            showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder:(context,state) => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        customTextFormFeild(
                            controller: emailController,
                            label: 'Email Address',
                            prefixIcon: const Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            error: 'Email Address must be added'),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextFormFeild(
                          controller: passwordController,
                          obscure: ShopLoginCupit.get(context).abscure,
                          error: 'password is must be added' ,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: ShopLoginCupit.get(context).abscureIcon,
                          suffixPressed: () {
                            ShopLoginCupit.get(context).abscurefun();
                          },
                          label: "Password ",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Conditional.single(
                          context: context, 
                          conditionBuilder: (BuildContext context) => state is! ShopLoginLoadingState , 
                          widgetBuilder: (BuildContext context) => Container(
                          color: Colors.indigo,
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCupit.get(context).userLogin(
                                  email:emailController.text, 
                                  password: passwordController.text);
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white,
                              fontSize: 19),
                            ),
                          ),
                        ), 
                          fallbackBuilder: (BuildContext context) =>const Center(child: CircularProgressIndicator(),)
                        ),
                         const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: 
                          [
                            const Text('Don\'t have an account? '),
            
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> const RegisterScreen()));
                            }, 
                            child: const Text('Register Now',))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
