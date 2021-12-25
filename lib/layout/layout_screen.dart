import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shop_app/layout/layout_cubit/layout_cubit.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styels/constants.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return BlocProvider.value(
      value: BlocProvider.of<ShopLayoutCubit>(context)
        ..getHomeData()
        ..getCategories()
        ..getFavoritesData()
        ..getUserData()
        ,
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            appBar: cubit.currentIndex == 2 || cubit.currentIndex == 3
                ? appBar(
                    color: Colors.white,
                    background: defultColor,
                    title: cubit.titile[cubit.currentIndex],
                    context: context,
                    condition: cubit.count != 0,
                    count: cubit.count)
                : appBar(
                    title: cubit.titile[cubit.currentIndex],
                    context: context,
                    condition: cubit.count != 0,
                    count: cubit.count),
            extendBody: true,
            body: Builder(builder: (context) {
              return OfflineBuilder(
                connectivityBuilder: (context, connectivity, child) {
                 connected = connectivity != ConnectivityResult.none;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                     child ,
                      Positioned(
                        height: 24.0,
                        left: 0.0,
                        right: 0.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: connected != true ? Colors.grey : null,
                          child: connected != true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "No connection",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                      height: 12.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                    ],
                  );
                },
                child: cubit.layoutScreen[cubit.currentIndex],
              );
            }),
            bottomNavigationBar: DotNavigationBar(
              dotIndicatorColor: Colors.grey[200],
              backgroundColor: Colors.grey[200],
              curve: Curves.linear,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomScreen(index);
              },
              items: [
                DotNavigationBarItem(
                  icon: const Icon(Icons.home),
                ),
    
                /// Categories
                DotNavigationBarItem(
                  icon: const Icon(Icons.apps),
                  selectedColor: defultColor,
                ),
    
                /// Likes
                DotNavigationBarItem(
                    icon: const Icon(Icons.favorite), selectedColor: Colors.red),
    
                /// Profile
                DotNavigationBarItem(
                  icon: const Icon(Icons.person),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
