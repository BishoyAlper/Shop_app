import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/moduls/login/login_shop_screen.dart';
import 'package:shoping_app/moduls/search_screen.dart';
import 'package:shoping_app/shared/components/components.dart';
import 'package:shoping_app/shared/network/local/cache_helper.dart';

class ShopLayoutScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopSuccessFavoritiesState){
          if(!state.model.status){
            showToast(msg: state.model.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state){
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text("salla", style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(
                icon: Icon(Icons.search,color: Colors.black,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                },
              ),
            ],
          ),
          body: cubit.bootomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}