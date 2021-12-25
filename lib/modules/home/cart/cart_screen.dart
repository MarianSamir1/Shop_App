import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/cart_models/get_cart_data_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/offline_screen.dart';
import 'package:shop_app/shared/styels/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'My Cart',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: backbutton(context),
            ),
          ),
          body: cubit.cartModel?.data.subTotale == 0 ? 
          emptyPage2(image: 'assets/images/empty_cart.svg' ,
          text: 'No Products Added Yet..' ,
          width: 200,
          hight: 200)
          :
           Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Material(
              borderRadius: BorderRadius.circular(40),
              color: Colors.grey[100],
              child: Column(
                children: [
                  //cartItem
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                        cartItem(cubit.cartModel!.data.cartItem[index],context),
                        itemCount: cubit.cartModel!.data.cartItem.length,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //subtotal //taxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Subtotal:',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w900)),
                      Text(' ${cubit.cartModel!.data.subTotale} LE',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(
                        width: 60,
                      ),
                      Text('Taxes:',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                      const Text(' 50 LE',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //check out box
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(' ${cubit.cartModel!.data.total+50}',
                              style: const TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.w600)),
                          const Text(' LE',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Material(
                            borderRadius: BorderRadius.circular(25),
                            elevation: 10,
                            color: defultColor,
                            child: SizedBox(
                              height: 48,
                              width: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                  Text(' Check Out',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Widget cartItem(CartItems cartItem , context ) => Dismissible(
    key: UniqueKey(),
    onDismissed: (direction){
        ShopLayoutCubit.get(context).addOrRemoveCartItem(productId: cartItem.productCartData.id);
      },
      background: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          child: const Icon(Icons.delete,color: Colors.red,size: 28,)),
      ),
      secondaryBackground:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: AlignmentDirectional.centerEnd,
          child: const Icon(Icons.delete,color: Colors.red,size: 28,)),
      ),
    child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            elevation: 2,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(cartItem.productCartData.image),
                    height: 110,
                    width: 110,
                  ),
                ),
                const SizedBox(width: 7,),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItem.productCartData.name,
                            maxLines: 3,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis, fontSize: 15)),
                                const Spacer(),
                        rowOfPriceAndOldPrice(
                            price: cartItem.productCartData.price,
                            oldPrice: cartItem.productCartData.oldPrice,
                            discount: cartItem.productCartData.discount)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.only(start: 10 , top: 2 ,bottom: 2),
                  height: 130,
                  width: 90,
                  child: Column(
                    children: [
                     iconBlusAndMinusInCartScreen(icon: const Icon(Icons.remove )),
                     const Spacer(),
                     Text('${cartItem.quantity}',
                     style: const TextStyle(
                       fontSize: 18
                     ),),
                     const Spacer(),
                     iconBlusAndMinusInCartScreen(icon: const Icon(Icons.add)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
  );
}
