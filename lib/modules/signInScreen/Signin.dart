import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/sharred/network/local/sharred.dart';
import '../../layout/home.dart';
import '../../sharred/components/components.dart';
import 'cubic/signInCubic.dart';
import 'cubic/signInStates.dart';


class Signin extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SignInCubit(),
        child: BlocConsumer<SignInCubit,SignInStates>(
            builder: (context , state) {
              return Scaffold(
                body:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          textfield(
                            ontap: (){},
                            InputType: TextInputType.name,
                            Controller: nameController,
                            labeltext: 'Name',
                            labelStyle: Colors.blue,
                            prefixicon: Icons.person,
                            maxLength: 16,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          textfield(
                            ontap: (){},
                            InputType: TextInputType.emailAddress,
                            Controller: emailController,
                            labeltext: 'Email',
                            labelStyle: Colors.blue,
                            prefixicon: Icons.email,
                            helperText: '***********@gmail.com'
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          textfield
                            (
                              ontap: (){},
                              InputType: TextInputType.visiblePassword,
                              Controller: passwordController,
                              labeltext: 'Password',
                              labelStyle: Colors.blue,
                              isPassword: SignInCubit.get(context).IsPassword,
                              prefixicon: Icons.lock,
                              sufixicon: SignInCubit.get(context).icon,
                              suffixPressed: () {
                                SignInCubit.get(context).ChangeVisiplitiy();
                              },
                            ),
                          SizedBox(
                            height: 20.0,
                          ),
                          textfield(
                            InputType: TextInputType.phone,
                            Controller: phoneController,
                            labeltext: 'Phone',
                            labelStyle: Colors.blue,
                            prefixicon: Icons.phone,
                            helperText: '01*********',
                            maxLength: 11,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SignInLoadingState,
                            builder: (context) => buttom(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                    SignInCubit.get(context).SignIn(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text
                                   );
                                 }},
                                 text: 'Sign In'
                              ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),

              );
            },
            listener: (context , state) {
           /*   if(state is SignInSucessState){
                  toast(massage: 'Done', IsError: false);
                  */
              /*Sharred.put(key: 'Token', value: state.Data.data!.token).
                  then(
                      (value) {
                        Token = state.Data.data!.token!;
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute
                              (builder: (context) => ShopHome()),
                                (route) => false);
                      }
                  );*//*
                }else{
                  toast(massage: 'Error', IsError: true);}*/
              if(state is SucessCreateUserState) {
                Sharred.put(key: 'id', value: state.id).then((value) {
                  NavigatorAndRemove(page: socialHome(),context: context );
                });
              }
            }
        ),
    );
  }
}
