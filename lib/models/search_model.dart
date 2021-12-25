class SearchModel{
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data{
  late List<SearchProducts> serachList = [];
  late int total;

  Data.fromJson(Map<String,dynamic> json){
    total = json['total'];
    json['data'].forEach((element){
     serachList.add(SearchProducts.fromJson(element));
    });
  }
}

class SearchProducts{

  late int id ;
  late dynamic price;
  late String image;
  late String name;
  late String description;

  SearchProducts.fromJson(Map<String , dynamic> data){

    id = data['id'];
    price = data ['price'];
    image = data['image'];
    name = data['name'];
    description = data['description'];

  }

}