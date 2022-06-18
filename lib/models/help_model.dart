class HelpModel{
  late List<Faqs> faqsList = [];

 HelpModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
     faqsList.add(Faqs.fromJson(element));
    });
  }
}

class Faqs{

  late int id ;
  late String quastion;
  late String answer;


  Faqs.fromJson(Map<String , dynamic> data){

    id = data['id'];
    quastion = data['question'];
    answer = data['answer'];

  }

}