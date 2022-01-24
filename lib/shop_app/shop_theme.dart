
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


const  defaultColor = Colors.deepOrange;

class MyThemes{

  static final darkTheme =ThemeData(
    primarySwatch:Colors.red,
    primaryColor: Colors.black,
    scaffoldBackgroundColor:HexColor('333739'),
    iconTheme: IconThemeData(
      color:Colors.white ,
    ) ,
    fontFamily: ' RobotoMono',


    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle:TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        size: 50,
        opacity: 100,
      ),
    ),




    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      selectedItemColor: Colors.red[800],
      unselectedItemColor: Colors.white,
      elevation: 10,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,),
    ),
    colorScheme: ColorScheme.dark(),
  );




  static final lightTheme = ThemeData(
    primarySwatch:defaultColor,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color:Colors.grey ,
    ) ,
    fontFamily: ' RobotoMono',



    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle:TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: Colors.black,
        size: 50,
        opacity: 100,
      ),
    ),





    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red[800],
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),),
    colorScheme: ColorScheme.light(),
  );
}