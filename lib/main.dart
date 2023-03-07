import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home.dart';
import 'package:social_app/sharred/bloc_observer.dart';
import 'package:social_app/sharred/components/constans.dart';
import 'package:social_app/sharred/network/local/sharred.dart';
import 'layout/cubit/SocialCubit.dart';
import 'layout/cubit/SocialStates.dart';
import 'modules/loginscreen/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await Sharred.init();
  id = Sharred.Get(key: 'id');
  Widget? page;
  if(id != null)
    page = socialHome();
  else
    page = Login();
  runApp(MyApp(page));
}

class MyApp extends StatelessWidget {

  Widget page;
  MyApp(this.page);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => SocialCubit()..getUserData(),
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state) {},
        builder: (context, state){
          return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: LightTheme,
                  themeMode: ThemeMode.light,
                  home: page,
                  );
        },
      ),
    );
  }
}
