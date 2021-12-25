import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_data_model.dart';
import 'package:shop_app/modules/home/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final int id ;
  const CategoriesDetailsScreen({required this.id, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider.value(
      value: BlocProvider.of<ShopLayoutCubit>(context)
        ..getCategoriesDataDetails(id)
        ,
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {},
        builder: (context, state) => 
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: backbutton(context),
            ),
            ),
            body: Conditional.single(
            context: context, 
            conditionBuilder: (context)=> state is! ShopGetCategoriesDetailsLoadingState, 
            widgetBuilder: (context)=> Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  itemBuilder: (context , index)=> itemBuilder(ShopLayoutCubit.get(context).categoriesDataModel!.dataModel.listModel[index], context), 
                  separatorBuilder: (context , index)=> const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ), 
                  itemCount:ShopLayoutCubit.get(context).categoriesDataModel!.dataModel.listModel.length),
              ),
            fallbackBuilder:(context)=> const Center(child: CircularProgressIndicator(),))
          ),
        )
      ),
    );
  }

  Widget itemBuilder(CategoriesListModel categoriesListModel, BuildContext context) => 
  InkWell(
    onTap: (){
       navigate(context, ProductDetailsScreen(categoriesListModel.id));
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
                              categoriesListModel.image,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          categoriesListModel.discount != 0
                              ? Container(
                                  height: 27,
                                  width: 150,
                                  color: Colors.red.withOpacity(0.92),
                                  child: Text(
                                    'DISCOUNT ${categoriesListModel.discount}' '%' '',
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
                          categoriesListModel.name,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis, fontSize: 15),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            rowOfPriceAndOldPrice(
                            price: categoriesListModel.price,
                            oldPrice: categoriesListModel.oldPrice,
                            discount: categoriesListModel.discount),
                            const Spacer(),
                             IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context).changeFavorite(id: categoriesListModel.id);
                          },
                          icon: Icon(
                            ShopLayoutCubit.get(context).favorites[categoriesListModel.id] == true? Icons.favorite : Icons.favorite_outline_outlined,
                            color: ShopLayoutCubit.get(context).favorites[categoriesListModel.id] == true? Colors.red :Colors.grey,
                            size: 30,
                          ))
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