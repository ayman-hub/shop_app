
import 'package:flutter/material.dart';



class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  Color defaultColor =  Color(0xFF512DA8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: defaultColor,
            size: 30,
          ),
          onPressed: (){Navigator.pop(context);},
        ),
        title: Text('Search',style: TextStyle(color:defaultColor ),),
      ) ,
      body: Center(child: Text(
        'SearchScreen',
        style: Theme.of(context).textTheme.bodyText1,
      )
      ),
    );
  }
}


