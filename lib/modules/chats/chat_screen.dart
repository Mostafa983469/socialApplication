import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import 'package:social_app/models/users.dart';
import 'package:social_app/sharred/components/components.dart';

import 'chat_details_Screen.dart';

class chatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
        builder: (context,state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0 ,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(5.0),
              child:  ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index) => getUsers(SocialCubit.get(context).users[index],context),
                separatorBuilder: (BuildContext context, int index) => Container(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                itemCount: SocialCubit.get(context).users.length,
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
        },
    );
  }
}

Widget getUsers (userModel model,context) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: InkWell(
    onTap: (){
      NavigatorPush(context: context, page: ChatDetailsScreen(model));
    },
    child: Container(
      height: 80.0,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.image}'),
            radius: 30.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0
            ),
          ),
        ],
      ),
    ),
  ),
);
