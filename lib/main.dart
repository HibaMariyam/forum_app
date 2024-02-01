import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/cubit/main_cubit.dart';
import 'package:forum_app/features/auth/cubit/auth_cubit.dart';

import 'package:forum_app/common/views/splash_screen.dart';
import 'package:forum_app/features/create/cubit/create_thread_cubit.dart';
import 'package:forum_app/features/delete/cubit/delete_cubit.dart';
import 'package:forum_app/features/edit/cubit/edit_cubit.dart';
import 'package:forum_app/features/home/cubit/home_cubit.dart';
import 'package:forum_app/features/profile/cubit/profile_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context)=>AuthCubit()..loadUser(),),
        BlocProvider<HomeCubit>(create: (context)=>HomeCubit()),
        BlocProvider<ProfileCubit>(create: (context)=>ProfileCubit()),
        BlocProvider<CreateThreadCubit>(create: (context)=>CreateThreadCubit()),
        BlocProvider<MainCubit>(create: (context)=>MainCubit()),
         BlocProvider<EditCubit>(create: (context)=>EditCubit()),
         BlocProvider<DeleteCubit>(create: (context)=>DeleteCubit()),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       home: SplashScreeen()
        ),
    );
 
  
  }
}
