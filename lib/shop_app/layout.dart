
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app/cash_shared_preference_helper.dart';
import 'package:shop_app/shop_app/dio_helper.dart';
import 'package:shop_app/shop_app/end_points.dart';
import 'package:shop_app/shop_app/login.dart';
import 'package:shop_app/shop_app/models/categories_screen.dart';
import 'package:shop_app/shop_app/models/favorites_screen.dart';
import 'package:shop_app/shop_app/models/home_model.dart';
import 'package:shop_app/shop_app/models/products_screen.dart';
import 'package:shop_app/shop_app/models/search_screen.dart';
import 'package:shop_app/shop_app/models/settings_screen.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Color defaultColor =  Color(0xFF512DA8);

    return BlocConsumer<ShopCubit ,ShopStates>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = ShopCubit .get (context);
        return ClipRRect (
          child: Scaffold(
            extendBody: true,   //ليا علاقه بالبوتوم نفيجاشن علشان الصور تتمدد في الفراغات
            appBar: AppBar(
              leading: const CircleAvatar(
                radius: 80,
                backgroundImage:AssetImage('assets/image/sala.png'),
              ),
              title: Text(
                'SALA',
                style: TextStyle(color:defaultColor ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo  (context,SearchScreen());
                },
                    icon: Icon(Icons.search),color: defaultColor ,),
                TextButton(
                    onPressed: ()
                    {
                      CacheHelper.removeData(key: 'token').
                      then((value){
                        if(value){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context)=> ShopLogin(),),
                            // الطريق السابق لل navigate عايز تسيبه ومممكن المستخدم يرجع ليه ولا بتلغيه ؟؟؟
                                ( route) { return false;}, );
                        }
                      });
                    },
                    child: Text('SIGN OUT',style: TextStyle(color:defaultColor ),)
                ),

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: buildBottomNavigation(context),
          ),
        );
      },
    );
  }
}




class  ShopCubit extends Cubit<ShopStates>{
  ShopCubit() :  super(ShopInitialState()) {
    print('super');
    getHomeData();
  }


  static ShopCubit get (context) => BlocProvider.of(context);

  int currentIndex = 0 ;
 List<Widget> screens =
 [
   ProductsScreen(),
  CategoriesScreen(),
   FavoritesScreen(),
   SettingsScreen(),
 ];
void changeBottom (int index)
{
  currentIndex = index;
  emit(ShopChangeBotttomNavState());
}

HomeModel? homeModel;
Future<dynamic> getHomeData() async {

  emit(ShopLoadingHomeDataState());
  DioHelper.getData(
      url:HOME,
     token: await CacheHelper.getData(key: 'token'),
success: (value){
  homeModel = HomeModel.fromJson(value);
 // printFullText(homeModel!.data!.banners[0].image.toString());
 // print(homeModel!.status);
  emit(ShopSuccessHomeDataState());
},catchError: (error){
    print(error.toString());
    emit(ShopErrorHomeDataState(error.toString()));
  }
  );
}
}


abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBotttomNavState extends ShopStates{}

class ShopLoadingState extends ShopStates {}
class ShopSuccessState extends ShopStates
{

}
class ShopErrorState extends ShopStates
{
  final String error;
  ShopErrorState(this.error);
}


class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates
{

}
class ShopErrorHomeDataState extends ShopStates
{
  final String error;
  ShopErrorHomeDataState(this.error);
}


Widget buildBottomNavigation (context){
  var cubit = ShopCubit .get (context);
  Color activeColor =  Color(0xFF512DA8);
  Color inactiveColor = Colors.grey;

  return BottomNavyBar(
    onItemSelected: (int index) {cubit.changeBottom(index);  },
   selectedIndex: cubit.currentIndex,
    items:<BottomNavyBarItem> [
      BottomNavyBarItem(
        icon:Icon(Icons.home,),
        title:Text('Home ',style: TextStyle(fontSize: 15 ),),
        textAlign: TextAlign.center,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      BottomNavyBarItem(
        icon:Icon(Icons.app_registration,),
        title:Text('Categories',style: TextStyle(fontSize: 15 ),),
        textAlign: TextAlign.center,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      BottomNavyBarItem(
        icon:Icon(Icons.favorite),
        title:Text('Favorites ',style: TextStyle(fontSize: 15),),
        textAlign: TextAlign.center,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
      BottomNavyBarItem(
        icon:Icon(Icons.settings),
        title:Text('Setting',style: TextStyle(fontSize: 15),),
        textAlign: TextAlign.center,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
      ),
    ],

  );

}

void navigateTo (context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=> SearchScreen() ,
  ),
);
 void printFullText(String text)
 {
   final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
   pattern.allMatches(text).forEach((match) => print(match.group(0)));
 }