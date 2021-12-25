import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/favorite_models/fav_products_data_model.dart';
import 'package:shop_app/modules/home/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/offline_screen.dart';
import 'package:shop_app/shared/styels/constants.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) => RefreshIndicator(
        onRefresh: ()async{
          cubit.getFavoritesData();
        },
        child: state is ShopGetFavorietsErrorsState || connected == false ? 
        Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyPage(),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.getFavoritesData();
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
        : Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                  color: defultColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: 
                   cubit.favoritesDataModel == null ?
            const Center(child: 
            CircularProgressIndicator(),) 
            :
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cubit.favoritesDataModel!.dataModel.listModel.isEmpty?
                    const Center(
                      child: Text('No Favorite Yet .. ',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey
                      ),),
                    )
                     : 
                    Conditional.single(
                        context: context,
                        conditionBuilder: (context) => state is! ShopGetFavorietsLoadingState,
                        widgetBuilder: (context) => ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => itemBuilder(cubit.favoritesDataModel!.dataModel.listModel[index], context),
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: cubit.favoritesDataModel!.dataModel.listModel.length),
                        fallbackBuilder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            )),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(ListModel listModel , context) => InkWell(
    onTap: (){
       navigate(context, ProductDetailsScreen(listModel.faveData.id));
    },
    child: SizedBox(
          height: MediaQuery.of(context).size.height*0.23,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              Center(
                child: Material(
                  elevation: 7,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                    width: 150,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Center(
                            child: Image.network(
                              listModel.faveData.image,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          listModel.faveData.discount != 0
                              ? Container(
                                  height: 27,
                                  width: 150,
                                  color: Colors.red.withOpacity(0.92),
                                  child: Text(
                                    'DISCOUNT ${listModel.faveData.discount}' '%' '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                )
                              : Container()
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: SizedBox(
                    height:MediaQuery.of(context).size.height*0.20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          listModel.faveData.name,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis, fontSize: 15),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            rowOfPriceAndOldPrice(
                            price: listModel.faveData.price,
                            oldPrice: listModel.faveData.oldPrice,
                            discount: listModel.faveData.discount),
                            const Spacer(),
                            ShopLayoutCubit.get(context).favorites[listModel.faveData.id] == true?
                            IconButton(
                                onPressed: () {
                                  ShopLayoutCubit.get(context).changeFavorite(id: listModel.faveData.id);
                                },
                                icon: const Icon(
                                   Icons.favorite ,
                                  color: Colors.red,
                                  size: 30,
                                )):
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                          ],
                        ),
                        Center(
                          child: ElevatedButton.icon(
                              onPressed: () {
  
                              },
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Add To Cart')),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
  );
}
