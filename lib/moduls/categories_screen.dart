import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return ListView.separated(
          itemBuilder:(context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder:(context, index) => Container(width: double.infinity, height: 1.0, color: Colors.grey[300],),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0),
        Text(model.name, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
