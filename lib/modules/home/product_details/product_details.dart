import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styels/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  int id;
  ProductDetailsScreen(this.id, {Key? key}) : super(key: key);

  final PageController _controller = PageController();
  
  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    return BlocProvider.value(
      value: BlocProvider.of<ShopLayoutCubit>(context)
        ..getProductDataDetails(id)
        ,
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                  body: Conditional.single(
                    context: context, 
                    conditionBuilder: (context) => state is! ShopGetProductsDetailsLoadingState ,
                   widgetBuilder: (context)=> Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          backbutton(context),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopLayoutCubit.get(context)
                                    .changeFavorite(id: cubit.productsModel!.id);
                              },
                              icon: Icon(
                                ShopLayoutCubit.get(context)
                                            .favorites[cubit.productsModel!.id] ==
                                        true
                                    ? Icons.favorite
                                    : Icons.favorite_outline_outlined,
                                color: ShopLayoutCubit.get(context)
                                            .favorites[cubit.productsModel!.id] ==
                                        true
                                    ? Colors.red
                                    : Colors.grey,
                                size: 35,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //products Images
                      SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: PageView.builder(
                            controller: _controller,
                            itemCount: cubit.productsModel!.images.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Image(
                                  image: NetworkImage(cubit.productsModel!.images[index]),
                                )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: cubit.productsModel!.images.length,
                          effect: ScrollingDotsEffect(
                            activeDotColor: defultColor,
                            dotColor: Colors.grey.withOpacity(0.6),
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 6,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // add to cart //product price 
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('${cubit.productsModel!.price} LE',
                              style: const TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            width: 10,
                          ),
                          cubit.productsModel!.discount == 0
                              ? Container()
                              : Text('${cubit.productsModel!.oldPrice} LE',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.addOrRemoveCartItem(productId: cubit.productsModel!.id);
                              },
                              icon: cubit.cartIds[cubit.productsModel!.id] !=null ? const Icon(
                                Icons.shopping_cart,
                                size: 27,
                                color: Colors.red,
                              ): Icon(
                                Icons.shopping_cart_outlined,
                                size: 27,
                                color: Colors.grey[700],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Text(
                              cubit.productsModel!.name.split(' ')[0],
                              style: TextStyle(
                                  color: defultColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Material(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                 cubit.productsModel!.name,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18.5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  color: defultColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              type: MaterialType.card,
                              color: Colors.indigo[50],
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  cubit.productsModel!.description,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                                  ),
                                ),
                  fallbackBuilder:(context)=> const Center(child: CircularProgressIndicator(),)
                  )),
            );
          }),
    );
  }
}
