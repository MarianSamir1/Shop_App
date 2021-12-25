class UserLoginModel{
 late  bool status;
 late  dynamic message;
  UserData? data;

 UserLoginModel.fromJson(Map<String,dynamic> model){
   status = model['status'];
   message = model['message'];
   data = model['data'] != null ? UserData.fromJson(model['data']) : null;
 }
}

class UserData{
 late int id;
 late String name;
 late  String email;
 late  String phone;
 late  String image;
 late  dynamic points;
 late  dynamic credit;
 late  String token;

 //named constructor
  UserData.fromJson(Map<String , dynamic> dataModel){
    id = dataModel['id'];
    name = dataModel['name'];
    email = dataModel['email'];
    phone = dataModel['phone'];
    image = dataModel['image'] ;
    points = dataModel['points'];
    credit = dataModel['credit'];
    token = dataModel['token'];
  }
}