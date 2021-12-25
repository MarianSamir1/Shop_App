class HomeModel {
 late bool status;
 late HomeDataModel data;

 HomeModel.fromJson(Map<String , dynamic> homeJson){
   status = homeJson['status'];
   data = HomeDataModel.fromJson(homeJson['data']);
 }
}

class HomeDataModel{
  late List<BannerModel> banners =[];
  late List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String , dynamic> dataJson){
    dataJson['banners'].forEach((value){
      banners.add(BannerModel.fromJson(value));
    });

    dataJson['products'].forEach((value){
     products.add(ProductsModel.fromJson(value));
    });
  }
}

class BannerModel {
  late int id ;
  late String image;

  BannerModel.fromJson(Map<String , dynamic> bannerJson ){
    id = bannerJson['id'];
    image = bannerJson['image'];
  }
}

class ProductsModel {
  late int id ;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String name;
  late String image;
  late List<String> images = [];
  late String description;
  late bool inFav;
  late bool inCart;


  ProductsModel.fromJson(Map<String , dynamic> productsJson ){
    id = productsJson['id'];
    price = productsJson['price'];
    oldPrice = productsJson['old_price'];
    discount = productsJson['discount'];
    name = productsJson['name'];
    image = productsJson['image'];
    inFav = productsJson['in_favorites'];
    inCart = productsJson['in_cart'];
    description = productsJson['description'];
    productsJson['images'].forEach((value){
      images.add(value);
    });
  }
}