class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{

  List<BannersModel> ? banners;
  List<ProductsModel>? products;

  HomeDataModel.fromJson(Map<String,dynamic>  json){
    banners = [];
    products = [];
    if(json['banners'] != null){
      json['banners'].forEach((element) {
        banners?.add(BannersModel.fromJson(element));
      });
    }

    if(json['products'] != null){
      json['products'].forEach((element) {
        products?.add(ProductsModel.fromJson(element));
      });
    }
  }
}

class BannersModel{
  int? id;
  String? image;

  BannersModel.fromJson(Map<String,dynamic> json){

    id= json['id'];
    image = json['image'].toString() ;
  }
}
class ProductsModel{
  int? id ;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductsModel.fromJson(Map<String,dynamic> json){
    id= json['id'];
    oldPrice= json['old_price'].toString();
    discount= json['discount'].toString();
    image= json['image'].toString();
    name= json['name'].toString();
    inFavorites= json['in_favorites'];
    inCart= json['in_cart'];
  }
}