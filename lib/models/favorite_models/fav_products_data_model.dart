class FavoritesDataModel{
  late bool status ;
  late Data dataModel ;

  FavoritesDataModel.fromJson(Map<String , dynamic> dataJson){
    status = dataJson['status'];
    dataModel = Data.fromJson(dataJson['data']);
  }
}
class Data{
  late int currentPage;
  late List<ListModel> listModel = [];

  Data.fromJson(Map<String , dynamic> data){
    currentPage = data['current_page'];
    data['data'].forEach((element){
     listModel.add(ListModel.fromJson(element));
    });
  }
}

class ListModel{

 late int id;
 late FaveData faveData;

  ListModel.fromJson(Map<String , dynamic> data){
    id = data['id'];
    faveData = FaveData.fromJson(data['product']);
  }
}

class FaveData{
  late int id ;
  late dynamic price;
  late dynamic oldPrice;
  late int discount ; 
  late String image;
  late String name;
  late String description;

  FaveData.fromJson(Map<String , dynamic> data){

    id = data['id'];
    price = data ['price'];
    oldPrice = data['old_price'];
    discount = data['discount'];
    image = data['image'];
    name = data['name'];
    description = data['description'];

  }
}