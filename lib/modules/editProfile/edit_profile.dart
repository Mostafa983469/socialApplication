import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/SocialCubit.dart';
import 'package:social_app/layout/cubit/SocialStates.dart';
import '../../sharred/components/components.dart';
class editProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
        listener: (context , state ){},
        builder: (context , state ){
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          nameController.text = SocialCubit.get(context).model.name!;
          bioController.text = SocialCubit.get(context).model.bio!;
          phoneController.text = SocialCubit.get(context).model.phone!;
          return  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 250.0,
                          child :Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                             children: [
                                Stack(
                                  children :
                                  [
                                    Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      bottom: 50.0,
                                    ),
                                    child: Image(
                                      width: double.infinity,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                      image: get(coverImage,false,context) ,
                                    ),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                      radius: 20.0,
                                      child: IconButton(
                                        onPressed: (){
                                          SocialCubit.get(context).updateCoverImage();
                                        },
                                        icon: Icon(Icons.browser_updated),
                                      ),
                                  ),
                                    ),
                                  ],
                                  alignment: AlignmentDirectional.topEnd,
                                ),
                                Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children:
                                [
                                  Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 25.0,
                                  ),
                                  child : CircleAvatar(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    radius: 64.0,
                                    child: CircleAvatar(
                                      backgroundImage: get(profileImage,true,context),
                                      radius: 60.0,
                                    ),
                                  )
                              ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      child: IconButton(
                                        onPressed: (){
                                          SocialCubit.get(context).updateProfileImage();
                                        },
                                        icon: Icon(Icons.browser_updated),
                                      ),
                                    ),
                                  ),
                                ],
                          ),
                              ],
                          ),
                        ),
                        SizedBox(
                      height: 10.0,
                    ),
                        if(SocialCubit.get(context).profileImage != null
                            || SocialCubit.get(context).coverImage != null)
                          Row(
                          children: [
                              if(SocialCubit.get(context).profileImage != null)
                                Expanded(
                              child: buttom(
                                  onpressed: (){
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                    );
                                  },
                                  text: 'update profile',
                              ),
                            ),
                              SizedBox(
                              width: 5.0,
                            ),
                              if(SocialCubit.get(context).coverImage != null)
                                Expanded(
                              child: buttom(
                                onpressed: (){
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                  );
                                },
                                text: 'update cover',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textfield(
                          InputType: TextInputType.name,
                          Controller: nameController,
                          labeltext: 'Name',
                          labelStyle: Colors.blue,
                          prefixicon: Icons.person,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textfield(
                          InputType: TextInputType.text,
                          Controller: bioController,
                          labeltext: 'bio',
                          labelStyle: Colors.blue,
                          prefixicon: Icons.info,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textfield(
                          InputType: TextInputType.number,
                          Controller: phoneController,
                          labeltext: 'phone',
                          labelStyle: Colors.blue,
                          prefixicon: Icons.phone,
                          maxLength: 11,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          width: 100.0,
                          height: 60.0,
                          color: Colors.lightBlue,
                          child: TextButton(
                            onPressed: (){
                              SocialCubit.get(context).update(
                                name: nameController.text,
                                bio: bioController.text,
                                phone: phoneController.text,
                              );
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black
                              ),
                            ),
                          ),
                        ),
                     ],
                    ),
                  ),
                ),
          );
        },
    );
  }
  ImageProvider get(var image,bool profile,context){
    if (image != null)
      return FileImage(image);
    else if (profile)
      return NetworkImage('${SocialCubit.get(context).model.image}');
    else
      return NetworkImage('${SocialCubit.get(context).model.cover}');
  }
}
