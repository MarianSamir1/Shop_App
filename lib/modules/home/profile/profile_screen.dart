import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);

    if (cubit.userData != null){
      nameController.text = cubit.userData!.data!.name;
    phoneController.text = cubit.userData!.data!.phone;
    emailController.text = cubit.userData!.data!.email;
    }
    
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {
        if (state is ShopUpdateProfileDataSuccessState) {
          if (state.userData.status) {
            showToast(msg: state.userData.message, state: ToastStates.SUCCRSS);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.userData != null,
            widgetBuilder: (context) =>
                itemBuilder(cubit.userData!.data, state , context),
            fallbackBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget itemBuilder(UserData? data, ShopLayoutState state, BuildContext context) =>
      SingleChildScrollView(
        child: Column(
          children: [
            //image
            SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(350, 150),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Material(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          
                          data!.image,
                          fit: BoxFit.cover,
                          height: 170,
                          width: 170,
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateProfileLoadingState)
                      const LinearProgressIndicator(),
                     if (state is ShopUpdateProfileLoadingState)
                    const SizedBox(
                      height: 20,
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
                      height: 30,
                    ),
                    Container(
                      color: Colors.indigo,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopLayoutCubit.get(context).updateProfileData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        child: const Text(
                          'Upddate Your Information',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
