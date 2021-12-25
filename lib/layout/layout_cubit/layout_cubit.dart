import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_cubit/states.dart';
import 'package:shop_app/models/cart_models/add_to_cart_model.dart';
import 'package:shop_app/models/cart_models/get_cart_data_model.dart';
import 'package:shop_app/models/categories_model/categories_data_model.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/favorite_models/change_fav_model.dart';
import 'package:shop_app/models/favorite_models/fav_products_data_model.dart';
import 'package:shop_app/models/home_models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/home/categores/categores_screen.dart';
import 'package:shop_app/modules/home/favorates/fav_screen.dart';
import 'package:shop_app/modules/home/products/products_screen.dart';
import 'package:shop_app/modules/home/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styels/constants.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutState> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  List<Color> colorList = [
    Colors.teal.shade300,
    Colors.redAccent.shade100,
    Colors.cyan,
    Colors.red.shade400,
  ];
  List<String> titile = ['Salla', 'Categories', 'Favorites', 'Profile'];
  List<Widget> layoutScreen = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavorateScreen(),
    ProfileScreen()
  ];

  int count = 0;

  int currentIndex = 0;

  Map<int, bool> cart = {};

  changeBottomScreen(int index) {
    currentIndex = index;
    emit(ShopBottomNavChangeState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLayoutHomeDataLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favorites.addAll({element.id: element.inFav});
        cart.addAll({element.id: element.inCart});
      }
      emit(ShopLayoutHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutHomeDataErrorState(error.toString()));
    });
  }

  ProductsModel? productsModel;

  void getProductDataDetails(int id) {
    emit(ShopGetProductsDetailsLoadingState());
    DioHelper.getData(url: '$GET_PRODUCT_Details/$id', token: token)
        .then((value) {
      productsModel = ProductsModel.fromJson(value.data['data']);
      print('get productes details');
      emit(ShopGetProductsDetailsSuccessState());
    }).catchError((error) {
      emit(ShopGetProductsDetailsErrorState(error));
    });
  }

  Map<int, bool> favorites = {};

  ChangeFavoModel? favoModle;

  void changeFavorite({required int id}) {
    favorites[id] = !favorites[id]!;
    emit(ShopLayoutChangeFavState());

    DioHelper.postData(url: FAVORITES, data: {'product_id': id}, token: token)
        .then((value) {
      favoModle = ChangeFavoModel.fromJson(value.data);
      if (favoModle!.status == false) {
        favorites[id] = !favorites[id]!;
      } else {
        getFavoritesData();
      }
      emit(ShopLayoutChangeFavSuccessState());
    }).catchError((error) {
      favorites[id] = !favorites[id]!;
      emit(ShopLayoutChangeFavErrorState(error.toString()));
    });
  }

  FavoritesDataModel? favoritesDataModel;

  void getFavoritesData() {
    emit(ShopGetFavorietsLoadingState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesDataModel = FavoritesDataModel.fromJson(value.data);
      emit(ShopGetFavorietsSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGetFavorietsErrorsState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }

  CategoriesDataModel? categoriesDataModel;
  void getCategoriesDataDetails(int id) {
    emit(ShopGetCategoriesDetailsLoadingState());
    DioHelper.getData(url: '$GET_CATEGORIES_Details/$id', token: token)
        .then((value) {
      categoriesDataModel = CategoriesDataModel.fromJson(value.data);
      print('get categries details');
      emit(ShopGetCategoriesDetailsSuccessState());
    }).catchError((error) {
      emit(ShopGetCategoriesDetailsErrorState(error));
    });
  }

  UserLoginModel? userData;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userData = UserLoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGetUserDataErrorState(error.toString()));
    });
  }

  void updateProfileData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
            url: UPDATE_PROFILE,
            data: {'name': name, 'phone': phone, 'email': email},
            token: token)
        .then((value) {
      userData = userData = UserLoginModel.fromJson(value.data);
      print(userData!.status);
      print(userData!.message);
      emit(ShopUpdateProfileDataSuccessState(userData!));
    }).catchError((error) {
      emit(ShopUpdateProfileDataErrorState(error));
    });
  }

  AddOrRemoveToCartModel? addOrRemoveToCartModel;

  void addOrRemoveCartItem({required int productId}) {
    cart[productId] = !cart[productId]!;
    emit(ShopAddOrRemoveCartDataLoadingState());
    DioHelper.postData(
            url: CARTS, data: {'product_id': productId}, token: token)
        .then((value) {
      addOrRemoveToCartModel = AddOrRemoveToCartModel.fromJson(value.data);
      if (addOrRemoveToCartModel!.status == false) {
        cart[productId] = !cart[productId]!;
      } else {
        getCartData();
      }
      emit(ShopAddOrRemoveCartDataSuccessState(addOrRemoveToCartModel!));
    }).catchError((error) {
      print(error.toString());
      cart[productId] = !cart[productId]!;
      emit(ShopAddOrRemoveCartDataErrorState(error.toString()));
    });
  }

  CartModel? cartModel;
  int cartCount = 1;

  blus() {
    cartCount++;
    emit(BlusState());
  }

  minus(int id) {
    if (cartCount != 0) {
      cartCount--;
      emit(MinusState());
    } else {
      emit(MinusState());
    }
  }

  void getCartData() {
    emit(ShopGetCartDataLoadingState());
    DioHelper.getData(url: CARTS, token: token).then((value) {
      cartModel = CartModel.fromJason(value.data);
      print(cartModel!.status);
      print(cartModel!.data.cartItem);
      count = cartModel!.data.cartItem.length;
      emit(ShopGetCartDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCartDataErrorState(error.toString()));
    });
  }

  SearchModel? searchModel;

  void getSearch({required String searchKey}) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: SEARCH,
            data: {
              "text": searchKey,
            },
            token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data.serachList);
      emit(SearchSuccessState());
    }).catchError((error) {
      print("Search Error : ${error.toString()}");
      emit(SearchErrorState(error.toString()));
    });
  }
}
