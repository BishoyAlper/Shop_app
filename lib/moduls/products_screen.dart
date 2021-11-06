import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/models/categories_model.dart';
import 'package:shoping_app/models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<ShopCubit, ShopStates>(
      listener:(context, state){},
      builder:(context, state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context)=> productBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoriesModel, context),
          fallback:(context)=> Center(),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: .9,
              enableInfiniteScroll: true,
              // 2awz arg3la
              reverse: false,
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("categories",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context, index)=> buildCategoryItem(categoriesModel.data.data[index]),
                      separatorBuilder:(context, index)=> SizedBox(width: 15.0) ,
                      itemCount: categoriesModel.data.data.length,
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("New Products",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1/1.6,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(model.data.products.length, (index) => buildGridProduct(model.data.products[index], context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8),
          width: 100.0,
          height: 20.0,
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridProduct(Products model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discound != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: Text("DISCOUNT", style: TextStyle(fontSize: 11.0, color: Colors.white),),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),

              ),
              Row(
                children: [
                  Text('${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3, color: Colors.blue),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discound != 0)
                    Text('${model.old_price.round()}',
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
                        ShopCubit.get(context).changeFavorite(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorities[model.id] ? Colors.blue : Colors.grey,
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
  );
}
