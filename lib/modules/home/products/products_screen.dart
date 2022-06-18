import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/modules/home/products/products_builder.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/offline_screen.dart';
import 'package:shop_app/shared/styels/constants.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {
        if (state is ShopAddOrRemoveCartDataSuccessState) {
          showToast(
              msg: state.addOrRemoveToCartModel.message,
              state: ToastStates.SUCCRSS);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
            onRefresh: () async {
              cubit.getHomeData();
              
            },
            child: state is ShopLayoutHomeDataErrorState || connected == false
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyPage(),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.getHomeData();
                        },
                        child: Text(
                          'RETRAY',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.red[700],
                              fontFamily: 'normal'),
                        ),
                      ),
                    ],
                  )
                : Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        cubit.homeModel != null &&
                        cubit.categoriesModel != null,
                    widgetBuilder: (context) => productsBuilder(
                        cubit.homeModel!, context, cubit.categoriesModel!),
                    fallbackBuilder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        )));
      },
    );
  }

}
