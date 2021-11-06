import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<ShopCubit, ShopStates>(
      listener:(context, state){},
      builder:(context, state){
        return ConditionalBuilder(
          condition: state is ShopLoadingGetFavoriteState,
          builder: (context) =>ListView.separated(
              itemBuilder:(context, index) => buildFavItem(ShopCubit.get(context).favoriteModel.data.data[index], context),
              separatorBuilder:(context, index) => Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey,
              ),
              itemCount: ShopCubit.get(context).favoriteModel.data.data.length
          ),
          fallback:(context)=> Center(child:CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoriteData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product.image),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
              if(model.product.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text("DISCOUNT", style: TextStyle(fontSize: 11.0, color: Colors.white),),
                ),
            ],
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(model.product.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3, color: Colors.blue),
                    ),
                    SizedBox(width: 5.0,),
                    if(model.product.oldPrice != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10.0,
                            decoration: TextDecoration.lineThrough,
                            height: 1.3,
                            color: Colors.grey
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorite(model.product.id);
                      },
                      icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorities[model.product.id] ? Colors.blue : Colors.grey,
                          radius: 15.0,
                          child: Icon(Icons.favorite_border, size: 20.0, color: Colors.white,)
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
