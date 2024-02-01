import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/features/auth/cubit/auth_cubit.dart';

import 'package:forum_app/features/auth/views/login_page.dart';
import 'package:forum_app/common/views/main_screen.dart';

class SplashScreeen extends StatelessWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthInitial){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
        }
        //authinitial ayi parnal avde token match aytla oral llan ane artham..apo nere login page kan direct cheydne..llenki success ayal homepage kum
        if(state is AuthSuccess){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
