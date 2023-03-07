import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import '../modules/add_post/addPost_screen.dart';
import '../modules/editProfile/edit_profile.dart';
import '../sharred/components/components.dart';


class socialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context)  => SocialCubit()..getUserData()..getPost()..getUsers(),
        child:BlocConsumer<SocialCubit,SocialStates>(
        listener: (context , state) {
          if(state is AddPostPageState){
            NavigatorPush(
                page: AddPostScreen(),
              context: context,
            );
          }
          else if(state is EditState){
            NavigatorPush(
              page: editProfileScreen(),
              context: context,
            );
          }
        },
        builder: (context , state) {
          SocialCubit cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:cubit.currentIndex,
              onTap: (index) {cubit.changeIndex(index);},
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                  label: 'feeds',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_outlined),
                  label: 'chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add_outlined),
                  label: 'add Post',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_contact_cal),
                  label: 'user',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                  label: 'settings',
                ),
              ],
            ),
          );
        },

      )
    );
  }
}
