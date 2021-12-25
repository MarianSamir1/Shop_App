class AddOrRemoveToCartModel{
 late bool status ;
 late String message;

 AddOrRemoveToCartModel.fromJson(Map<String, dynamic> json){
   status = json['status'];
   message = json['message'];
 } 

}