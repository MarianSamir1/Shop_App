import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/modules/home/categores/categores_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/offline_screen.dart';
import 'package:shop_app/shared/styels/constants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);
    return BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            cubit.getCategories();
          },
          child: state is ShopCategoriesErrorState || connected == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyPage(),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                           cubit.getCategories();
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
                  conditionBuilder: (context) => cubit.categoriesModel != null,
                  widgetBuilder: (context) => ListView.separated(
                      itemBuilder: (context, index) => itemBuilder(
                          cubit.categoriesModel!.dataModel.listDataModel[index],
                          index,
                          context),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 0,
                          ),
                      itemCount: cubit
                          .categoriesModel!.dataModel.listDataModel.length),
                  fallbackBuilder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
        );
      },
    );
  }

  Widget itemBuilder(
          ListDataModel listDataModel, int index, BuildContext context) =>
      InkWell(
        onTap: () {
          navigate(context, CategoriesDetailsScreen(id: listDataModel.id ,));
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Material(
              color: Colors.white,
              elevation: 7,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  // image
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 7,
                      child: Image.network(
                        listDataModel.image,
                        height: 130,
                        width: 130,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      listDataModel.name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          letterSpacing: 2),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ))
                ],
              ),
            )),
      );
}
