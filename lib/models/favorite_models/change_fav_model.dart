class ChangeFavoModel{
 late bool status ;
 late String message;

 ChangeFavoModel.fromJson(Map<String, dynamic> favData){
   status = favData['status'];
   message = favData['message'];
 } 

}