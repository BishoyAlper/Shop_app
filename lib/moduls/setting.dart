import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/layout/cubit/cubit.dart';
import 'package:shoping_app/layout/cubit/states.dart';
import 'package:shoping_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopSuccessUserDataState){
          nameController.text = state.uselModel.data.name;
          emailController.text = state.uselModel.data.email;
          phoneController.text = state.uselModel.data.phone;
        }
      },
      builder: (context, state){
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (String value)
                    {
                      if(value.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person
                ),

                SizedBox(height: 20.0,),

                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (String value)
                    {
                      if(value.isEmpty)
                        if(value.isEmpty){
                          return 'email must not be empty';
                        }
                      return null;
                    },
                    label: 'E-mail',
                    prefix: Icons.email
                ),

                SizedBox(height: 20.0,),

                defaultFormField(
                    controller:phoneController,
                    type: TextInputType.phone,
                    validator: (String value)
                    {
                      if(value.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone
                ),
              ],
            ),
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
