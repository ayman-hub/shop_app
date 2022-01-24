import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/shop_app/layout.dart';
import 'package:shop_app/shop_app/login.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
 runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      debugShowCheckedModeBanner: false,
      home:  MultiBlocProvider(providers: <BlocProvider>[
        BlocProvider<ShopCubit>(create: (BuildContext context)=>ShopCubit(),),
      ], child: Layout(),),
    );
  }
}
