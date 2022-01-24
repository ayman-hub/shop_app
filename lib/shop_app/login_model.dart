

class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;


  ShopLoginModel.fromJson(Map<String, dynamic>json)
  {
    print('getData::: $json');
    status = json['status'];
    message = json['message'];
    //  != null ,?? null الاثنين نفس المعني
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}

class UserData
{
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;

   // named constructor
   UserData.fromJson(Map<String,dynamic>json)
   {
   id = json['id'];
   name = json['name'];
   email = json['email'];
   image = json['image'];
   points = json['points'];
   credit = json['credit'];
   token = json['token'];
   }


}