
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shop_app/shop_app/layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/shop_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color defaultColor =  Color(0xFF512DA8);

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return BuildCondition(
            condition: ShopCubit.get(context).homeModel!=null,
            builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel!),
            fallback: (context)=> Center(
              child: CollectionSlideTransition(
                children: [
                Icon(Icons.circle,color: defaultColor,size: 15,) ,
                  SizedBox(width: 3,),
                  Icon(Icons.circle,color: defaultColor,size: 15,) ,
                  SizedBox(width: 3,),
                  Icon(Icons.circle,color: defaultColor,size: 15,) ,
                  SizedBox(width: 3,),
                  Icon(Icons.circle,color: defaultColor,size: 15,) ,
                  SizedBox(width: 3,),
                  Icon(Icons.circle,color: defaultColor,size: 15,) ,
              ],)
            ),
          );
        },
    );
  }

  Widget productsBuilder(HomeModel model)=> SingleChildScrollView (
    child: Column(
      children: [
        CarouselSlider(
          items:
          model.data!.banners?.map((e) =>  Image(
             image: NetworkImage('${e.image}'),
             width: double.infinity,
             fit: BoxFit.cover,
           ),).toList(),
          options: CarouselOptions(
                  height: 250,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          )
      ),

        SizedBox(height: 10,),


        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
             mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.44,
            children: List.generate(
                model.data?.products?.length??0,
                    (index) =>buildGridProduct(  model.data!.products![index] )
          ),
          ),
        )],
    ),
  );

  Widget buildGridProduct(ProductsModel model)=> Column(
    children: [
      Image(
        image: NetworkImage(model.image!),
        width: double.infinity,
        height: 200,
      ),
      Text(
        model.name.toString(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],

  );
}
