import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/register_cupit/register_cupit.dart';
import 'package:shop_app/modules/register/register_cupit/states.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

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
        create: (context) => ShopRegisterCupit(),
        child: BlocConsumer<ShopRegisterCupit, ShopRegisterState>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.registerModel.status) {
                fToast.showToast(
                  child: showToastWithIcon(
                    msg: state.registerModel.message,
                  ),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              } else {
                showToast(
                    msg: state.registerModel.message, state: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
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
                          "Register page",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        customTextFormFeild(
                            controller: nameController,
                            label: 'Name',
                            prefixIcon: const Icon(Icons.person),
                            keyboardType: TextInputType.name,
                            error: 'Your Name must be added'),
                        const SizedBox(
                          height: 20,
                        ),
                        customTextFormFeild(
                            controller: phoneController,
                            label: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone),
                            keyboardType: TextInputType.number,
                            error: 'Phone Number must be added'),
                        const SizedBox(
                          height: 20,
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
                          obscure: ShopRegisterCupit.get(context).abscure,
                          error: 'password is must be added',
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon:
                              ShopRegisterCupit.get(context).abscureIcon,
                          suffixPressed: () {
                            ShopRegisterCupit.get(context).abscurefun();
                          },
                          label: "Password ",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (BuildContext context) =>
                                state is! ShopRegisterLoadingState,
                            widgetBuilder: (BuildContext context) => Container(
                                  color: Colors.indigo,
                                  width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopRegisterCupit.get(context)
                                            .userRegister(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                      }
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 19),
                                    ),
                                  ),
                                ),
                            fallbackBuilder: (BuildContext context) =>
                                const Center(
                                  child: CircularProgressIndicator(),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
