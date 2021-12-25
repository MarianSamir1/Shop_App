import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/home/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/offline_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    ShopLayoutCubit.get(context).searchModel!.data.serachList=[];
    super.initState();
  }
  var formKey = GlobalKey<FormState>();

  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: backbutton(context),
            ),
          ),
          body:Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: searchcontroller ,
                    keyboardType: TextInputType.text ,
                    onChanged: (String value){
                      ShopLayoutCubit.get(context).getSearch(searchKey: value);
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      labelText: 'Search'),
                  )
                ),
                const SizedBox(height: 10,),
                   ShopLayoutCubit.get(context).searchModel?.data.serachList == null || searchcontroller.text == ''?
            Expanded(
              child: emptyPage2(
                image: 'assets/images/search.svg', 
                text: 'Search For Products..',
                width: 150 ,
                hight: 150)
            ):
             Conditional.single(
              context: context, 
              conditionBuilder: (context) => state is! SearchLoadingState, 
              widgetBuilder: (context) => ShopLayoutCubit.get(context).searchModel!.data.total == 0?
              Expanded(
              child: emptyPage2(
                image: 'assets/images/not_found.svg', 
                text: 'This Product Not Found..',
                width: 150 ,
                hight: 150)
            )
              : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context , indx) => const Divider(),
                  itemBuilder: (context , index)=> itemBuilder(ShopLayoutCubit.get(context).searchModel!.data.serachList[index], context),
                  itemCount: ShopLayoutCubit.get(context).searchModel!.data.serachList.length),
              ),
                 
              fallbackBuilder: (context)=> const LinearProgressIndicator()),
              ],
            ),
          ));
      } );
  }

  Widget itemBuilder(SearchProducts searchProducts ,BuildContext context) => 
  InkWell(
    onTap: (){
       navigate(context, ProductDetailsScreen(searchProducts.id));
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
                    child: Center(
                      child: Image.network(
                        searchProducts.image,
                        height: 150,
                        width: 150,
                      ),
                    ),
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
                          searchProducts.name,
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis, fontSize: 15),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text('${searchProducts.price} LE',
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
                            const Spacer(),
                             IconButton(
                          onPressed: () {
                            ShopLayoutCubit.get(context).changeFavorite(id: searchProducts.id);
                          },
                          icon: Icon(
                            ShopLayoutCubit.get(context).favorites[searchProducts.id] == true? Icons.favorite : Icons.favorite_outline_outlined,
                            color: ShopLayoutCubit.get(context).favorites[searchProducts.id] == true? Colors.red :Colors.grey,
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