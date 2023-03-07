import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import 'package:social_app/models/users.dart';

import '../../models/massage.dart';


class ChatDetailsScreen extends StatelessWidget {
  userModel model;
  var massageController = TextEditingController();
  ChatDetailsScreen(this.model);
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext) {
          SocialCubit.get(context).GetMassage(receiverId: model.id!);
          return BlocConsumer<SocialCubit,SocialStates>(
            listener: (context,state){},
            builder: (context,stata) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('${model.image}'),
                        radius: 20.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${model.name}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ],
                  ),
                ),
                body:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context , index) {
                                if(SocialCubit.get(context).massages[index].receiverID == model.id)
                                  return getMyMassage(SocialCubit.get(context).massages[index]);
                                return getMassage(SocialCubit.get(context).massages[index]);
                              },
                              separatorBuilder: (context , index) => SizedBox(height: 5.0,),
                              itemCount: SocialCubit.get(context).massages.length
                          ),
                        ),
                        Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: massageController,
                                    decoration: InputDecoration(
                                      hintText: 'write your massage',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  child: MaterialButton(
                                    color: Colors.blueAccent,
                                    minWidth: 1.0,
                                    onPressed: (){
                                      SocialCubit.get(context).sendMassage(
                                        data: DateTime.now().toString(),
                                        text: massageController.text,
                                        receiverId: model.id!,
                                      );
                                      massageController.text = '';
                                    },
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              );
            },
          );
        },
    );
  }
}
 Widget getMyMassage (Massage massage) => Align(
   alignment: AlignmentDirectional.centerEnd,
   child: Container(
     padding: EdgeInsets.symmetric(
       vertical: 10.0,
       horizontal: 15.0,
     ),
     decoration: BoxDecoration(
       color: Colors.blueGrey,
       borderRadius: BorderRadiusDirectional.only(
         topEnd: Radius.circular(10.0),
         topStart: Radius.circular(10.0),
         bottomStart: Radius.circular(10.0),
       ),
     ),
     child: Text(
       '${massage.text}',
     ),
   ),
 );

 Widget getMassage (Massage massage) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    padding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    ),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(10.0),
        topStart: Radius.circular(10.0),
        bottomEnd: Radius.circular(10.0),
      ),
    ),
    child: Text(
      '${massage.text}',
    ),
  ),
);