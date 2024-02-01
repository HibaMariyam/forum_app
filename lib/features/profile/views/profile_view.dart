import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/features/auth/cubit/auth_cubit.dart';
import 'package:forum_app/features/auth/views/login_page.dart';

import 'package:forum_app/features/profile/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void initState() {
      final user=(context.read<AuthCubit>().state as AuthSuccess).user;
    context.read<ProfileCubit>().getProfileData(
  
      userId:user.id
   );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        if(state is ProfileFailure){
          return Text('error');
        }
        if(state is ProfileSuccess){
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: ()async {
              final user=(context.read<AuthCubit>().state as AuthSuccess).user;
              context.read<ProfileCubit>().getProfileData(
                userId: user.id
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                    TextButton(onPressed: ()async{
                      await SharedPreferences.getInstance()..remove("token");
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => true);
                    }, child: Text("logout")),
                for(final thread in state.threads)
             ListTile(
               title: Text(thread.content),),
                  Text((context.read<AuthCubit>().state as AuthSuccess).user.bio)
                  
                ],
              ),
            ),
          ),
        );
      } 
      return CircularProgressIndicator();
      
      },
    );
  }
}

