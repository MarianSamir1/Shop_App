import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_models/home_model.dart';
import 'package:shop_app/modules/home/categores/categores_details_screen.dart';
import 'package:shop_app/modules/home/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';

late int len;

int calculateListLenth(HomeModel homeModel) {
  return len =
      homeModel.data.products.length - (homeModel.data.products.length) ~/ 2;
}

Widget productsBuilder(
  HomeModel homeModel, context, CategoriesModel categoriesModel 
) =>
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn)),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index) =>  InkWell(
                      onTap: (){
                        navigate(context, CategoriesDetailsScreen(id: categoriesModel.dataModel.listDataModel[index].id,));
                      },
                      child: Container(
                      decoration: BoxDecoration(
                        color: ShopLayoutCubit.get(context).colorList[index],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Text(categoriesModel.dataModel.listDataModel[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500 ,
                          fontFamily: 'normal'
                        ),),
                      ) ,),
                    ),
                    separatorBuilder: (context , index)=> const SizedBox(width: 7,), 
                    itemCount: categoriesModel.dataModel.listDataModel.length),
                ),
               const SizedBox(height: 10,),
                const Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => itemBuilder(
                            context: context,
                              hieght: MediaQuery.of(context).size.height / 2.1,
                              productsModel: homeModel.data.products[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 7,
                              ),
                          itemCount: calculateListLenth(homeModel)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => itemBuilder(
                            context: context,
                              hieght: MediaQuery.of(context).size.height /2,
                              productsModel:
                                  homeModel.data.products[len + index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 7,
                              ),
                          itemCount: (homeModel.data.products.length) ~/ 2),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

Widget itemBuilder(
        {required dynamic hieght, required ProductsModel? productsModel , required context}) =>
    Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 10,
      child: Container(
        height: hieght,
        padding: const EdgeInsetsDirectional.only(start: 10, end: 5 , top: 10 ,bottom: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
             InkWell(
               onTap: (){
      navigate(context, ProductDetailsScreen(productsModel!.id));
    },
               child: Column(
                 children: [
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
                            Image(
                              image: NetworkImage(productsModel!.image),
                              height: 150,
                              width: 150,
                            ),
                            productsModel.discount != 0
                                ? Container(
                                    height: 27,
                                    width: 150,
                                    color: Colors.red.withOpacity(0.92),
                                    child: Text(
                                      'DISCOUNT ${productsModel.discount}' '%' '',
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
                 
                const SizedBox(
                  height: 25,
                ),
                Text(
                  productsModel.name,
                  maxLines: 2,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis, fontSize: 15),
                ),
                 ],
               ),
             ),
              Row(
                
                children: [
                    rowOfPriceAndOldPrice(
                        price: productsModel.price,
                        oldPrice: productsModel.oldPrice,
                        discount: productsModel.discount),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).changeFavorite(id: productsModel.id);
                      },
                      icon: Icon(
                        ShopLayoutCubit.get(context).favorites[productsModel.id] == true? Icons.favorite : Icons.favorite_outline_outlined,
                        color: ShopLayoutCubit.get(context).favorites[productsModel.id] == true? Colors.red :Colors.grey,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(height: 10,),
              ShopLayoutCubit.get(context).productsQuantity[productsModel.id] == null || ShopLayoutCubit.get(context).productsQuantity[productsModel.id] == 0?
                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        ShopLayoutCubit.get(context).addOrRemoveCartItem(productId: productsModel.id);
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add To Cart')),
                ):
                blusAndMinus(context , productsModel.id)
              
            ]),
      ),
    );
