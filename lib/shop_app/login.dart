import 'package:bloc/bloc.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shop_app/cash_shared_preference_helper.dart';
import 'package:shop_app/shop_app/dio_helper.dart';
import 'package:shop_app/shop_app/layout.dart';
import 'package:shop_app/shop_app/login_model.dart';
import 'package:shop_app/shop_app/register.dart';
import 'end_points.dart';
import 'package:progress_indicators/progress_indicators.dart';
class ShopLogin extends StatefulWidget {
  ShopLogin({Key? key}) : super(key: key);

  @override
  ShopLoginState createState() => ShopLoginState();
}


class ShopLoginState extends State<ShopLogin> {
  void navigateTo (context,widget)=>Navigator.push(context,
    MaterialPageRoute(
      builder: (context)=> widget,),);

  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isObscureText = true;

  bool isPress = true;

  Color  color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context )=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print (state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).
              then((value) =>Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context)=> Layout(),),
                // الطريق السابق لل navigate عايز تسيبه ومممكن المستخدم يرجع ليه ولا بتلغيه ؟؟؟
                    (Route<dynamic> route) => false,
              ));
              showToast(
                msgText: state.loginModel.message.toString(),
                state:ToastStates.SUCCESS,
              );
              // جمله ال else غير شغاله لان في حاله ال SuccessState بينفذ ال If  لكن في حاله الخطا بيتفذ ال error  state فانقلت الجزء الاخر من fluttertoast لجملة الايرور
            }else
              {
              print (state.loginModel.message);
              print('22222222222222222');

              showToast(
                  msgText: state.loginModel.message.toString(),
                  state:ToastStates.ERROR );
            }
          }
        },
        builder:(context,state){
          return  SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultTextForm(
                            preFixIcon: Icons.mail_outline,
                            onFieldSubmitted: (value) {print(value);},
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email must not empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultTextForm(
                              controller: password,
                              isObscureText: isObscureText,
                              keyboardType: TextInputType.visiblePassword,
                              onFieldSubmitted: (value)
                              {
                                print(value);
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin
                                    (
                                    email: email.text,
                                    password: password.text,
                                  );}
                                },
                              label: 'Password',
                              preFixIcon: Icons.lock,
                              sufFixIcon: (isPress
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off_sharp),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password must not empty';
                                }
                                return null;
                              },
                              onPressedSufIcon: () {
                                isPress = ! isPress;
                                isObscureText = ! isObscureText;
                                setState(() {});
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          BuildCondition(
                            condition:state is! ShopLoginLoadingState ,
                           fallback: (context)=> Center(
                             child: CollectionSlideTransition(
                               children: <Widget>[
                                 Icon(Icons.circle,color: Colors.deepPurple,size: 15,),
                                 Icon(Icons.circle,color: Colors.deepPurpleAccent,size: 15,),
                                 Icon(Icons.circle,color: Colors.purple,size: 15,),
                                 Icon(Icons.circle,color: Colors.purpleAccent,size: 15,),
                                 Icon(Icons.circle,color: Colors.pinkAccent,size: 15,),
                               ],
                             ),
                           ),
                           builder:(context) => defaultButton
                             (
                              radius: 15,
                              text: 'login',
                              onPressed: ()
                              {
                                if (formKey.currentState!.validate()) {
                                 ShopLoginCubit.get(context).userLogin
                                   (
                                     email: email.text,
                                     password: password.text,
                                 );}
                                },),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t Have Account?'),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context,RegisterScreen());
                                },
                                child: Text('Register Now',
                                  style: TextStyle(
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),),),),),),);
        } ,
      ),
    );
  }

  Widget defaultButton({
    double radius = 0,
    bool isUpperCase = true,
    double width = double.infinity,
    Color color = Colors.deepPurple,
    required Function() onPressed,
    required String text,
  }) =>
      Container(
        width: width,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
      );

  Widget defaultTextForm({
    required TextEditingController controller,
    required TextInputType keyboardType,
    Function(String)? onFieldSubmitted,
    Function(String)? onChange,
    Function()? onPressedSufIcon,
    required String? Function(String?)? validator,
    required String label,
    required IconData preFixIcon,
    IconData? sufFixIcon,
    bool isObscureText = false,
  }) =>
      TextFormField(
        cursorColor: Colors.deepPurple,
          validator: validator,
          controller: controller,
          obscureText: isObscureText,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChange,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: Icon(preFixIcon),
            suffixIcon: IconButton(
              onPressed: onPressedSufIcon,
              icon: Icon(sufFixIcon),
            ),
          ));
}


 class  ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get (context) => BlocProvider.of(context);

  ShopLoginModel? loginModel ;

  void userLogin({
   required String email,
    required String password,
 }){
    emit(ShopLoginLoadingState());
    DioHelper.postData
      (  url: LOGIN,
        data:
        {
          'email':email,
          'password':password,
        }, success: (value) {
        print('getValue:');
        print(value);
        loginModel = ShopLoginModel.fromJson(value);

        print(loginModel!.status);
        print(loginModel!.message);
        print(loginModel!.data!.token);
        emit(ShopLoginSuccessState(loginModel!));
      },catchError:((error)
        {
          print(error.toString());
          emit(ShopLoginErrorState(error.toString()));
          showToast(
              msgText: error.toString(),
              state:ToastStates.ERROR );
        }));
  }

}

abstract class ShopLoginStates {}
class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState(this.error);
}


Future showToast({
  required String msgText ,
  required ToastStates state,
}){
  return  Fluttertoast.showToast(
      msg: msgText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
// enum يعني حالات التوست تستخدم اذا بتحط نفس الحاجه بكذا اختيار
enum ToastStates {SUCCESS,ERROR,WARING}
Color chooseToastColor (ToastStates state){
  Color color;
  switch (state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARING:
      color= Colors.amber;
      break;
  }
  return color;
}
