import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/layout/shop_layout_screen.dart';
import 'package:shoping_app/moduls/login/cubit/cubit.dart';
import 'package:shoping_app/moduls/login/cubit/states.dart';
import 'package:shoping_app/moduls/shop_app_register.dart';
import 'file:///D:/flutterSetup/projecs/shoping_app/lib/shared/components/components.dart';
import 'package:shoping_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    // TODO: implement build
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
       listener: (context, state){
          if(state is ShopLoginSucessState) {
           if(state.loginModel.status) {
             print(state.loginModel.message);
             print(state.loginModel.data.token);
             print("انت صح");

             CasheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayoutScreen()),
                    (route) => false);
              });

            } else {
              print(state.loginModel.message);
            showToast(msg: state.loginModel.message, state: ToastState.ERROR);
           }
          }
        },
        builder: (context, state){
          return Scaffold(
              appBar: AppBar(),
              body:Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: 35.0,
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 20,
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(height: 30.0,),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return 'please enter your email Address';
                              }
                            },
                            label: "E-mail",
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(height: 30.0,),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,

                            onSubmit:(value){
                              if(formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            sufix: Icons.visibility_outlined,
                            validator: (String value){
                              if(value.isEmpty)
                              {
                                return 'passwrd is too short';
                              }
                            },
                            label: "password",
                            prefix: Icons.lock_outline,
                          ),
                          SizedBox(height: 15.0,),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) =>Container(
                              width: double.infinity,
                              height: 50.0,
                              color: Colors.blue,
                              child: FlatButton(
                                onPressed:(){
                                  if(formKey.currentState.validate())
                                  {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                child: Text("LOGIN",style: TextStyle(fontSize: 20.0, color: Colors.white),),
                              ),
                            ),
                            fallback:(context) => Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'n have an account?',
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterShopScreen()));
                                },
                                child: Text('REGISTER'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}