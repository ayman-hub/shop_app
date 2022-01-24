
import 'package:flutter/material.dart';
import 'package:shop_app/shop_app/cash_shared_preference_helper.dart';
import 'package:shop_app/shop_app/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
   // يستخدم في الباج فيو
   var boardController = PageController();
    Color  color = Colors.blue;
    bool isLast = false;
   List <BoardingModel> boarding =
   [
     BoardingModel(
       image: 'assets/image/welcome.png',
       title: 'name 1',
       body : 'body 1'
     ),
     BoardingModel(
       image: 'assets/image/shopdoor.jpeg',
       title: 'name 2',
       body : 'body 2'
     ),
     BoardingModel(
       image: 'assets/image/search.jpeg',
       title: 'name 3',
       body : 'body 3'
     ),
   ];


   void navigateTo (context,widget)=>Navigator.push(context,
       MaterialPageRoute(
       builder: (context)=> widget,),);

   void navigateAndFinish (context,widget)=> Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(
       builder: (context)=> widget(),),
     // الطريق السابق لل navigate عايز تسيبه ومممكن المستخدم يرجع ليه ولا بتلغيه ؟؟؟
         ( route) { return false;}, );


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){ submit(); },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: color,
                ),
              ),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView. builder
                (
                controller: boardController ,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: ( int index)
                  {
                  if(index == boarding.length-1)
                  {
                    isLast = true;
                  }else {
                    isLast = false;
                    }
                  },
                  itemBuilder: (context,index) => buildBoardingItems(boarding[index]),
                itemCount: boarding.length,
                ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: color,
                    spacing:5,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                    if(isLast)
                       {
                         submit();
                       }else{
                      boardController.nextPage
                        (
                        duration:Duration(milliseconds: 750,),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    setState(() {});
                    },
                  child: Icon(Icons.arrow_forward_ios,
                            color: Colors.white,),
                  backgroundColor:color ,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItems(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded (
        child: Image(
          image: AssetImage('${model.image}'),
        ),),
      Text('${model.title}',
        style:TextStyle(
          fontSize: 40,
        ) ,),
      SizedBox(height: 15,),
      Text('${model.body}',
        style:TextStyle(
          fontSize: 20,
        ) ,),
      SizedBox(height:20,),
      // PageView.builder(
      //     itemBuilder: (context){}
      // ),
    ],
  );


  void submit(){
     CacheHelper.saveData(key:'onBoarding',value : true).then((value) {

       if (value!) {
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
             builder: (context) => ShopLogin(),),
           // الطريق السابق لل navigate عايز تسيبه ومممكن المستخدم يرجع ليه ولا بتلغيه ؟؟؟
               (route) {
             return false;
           },);
       }
     } );

}
}
