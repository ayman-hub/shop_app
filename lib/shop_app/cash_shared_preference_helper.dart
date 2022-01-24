import 'package:get_storage/get_storage.dart';

class CacheHelper{
 static removeData({String? key})async{
   try{
      GetStorage storage = GetStorage();
      storage.remove(key.toString());
      return true;
    }catch(e){
     return e;
   }
  }
 static saveData({String? key, dynamic value})async{
   try{
      GetStorage storage = GetStorage();
      storage.write(key.toString(),value);
      return true;
    }catch(e){
     return e;
   }
  }
 static getData({String? key})async{
   try{
      GetStorage storage = GetStorage();
      return storage.read(key.toString());
    }catch(e){
     return e;
   }
  }
}