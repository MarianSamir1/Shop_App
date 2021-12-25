class CategoriesModel {
   late bool status ;
   late Data dataModel ;

  CategoriesModel.fromJson(Map<String , dynamic> dataJson){
    status = dataJson['status'];
    dataModel = Data.fromJson(dataJson['data']);
  }
}

class Data{

 late int currentPage;
  late List<ListDataModel> listDataModel = [];

  Data.fromJson(Map<String , dynamic> data){
    currentPage = data['current_page'];
    data['data'].forEach((element){
     listDataModel.add(ListDataModel.fromJson(element));
    });
  }
}
class ListDataModel{

 late int id;
 late String name;
 late String image;

  ListDataModel.fromJson(Map<String , dynamic> data){
    id = data['id'];
    name = data['name'];
    image = data['image'];
  }
}