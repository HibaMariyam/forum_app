import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/features/auth/cubit/auth_cubit.dart';
import 'package:forum_app/common/views/main_screen.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/images.png'))),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'password'),
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.msg)
                    )
                  );

              }
              if(state is AuthSuccess){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
              }},
              //replace cheydal epolla login page replace cheyd homepage varum..namk thirch login k povan patla..aa setup aakn aan..allel login cheyd homepage l vannalum back button on appbar use cheydt thurch loginpage kanne povan pattum
              builder: (context, state) => state is AuthLoading
              //bloclistener anel namk builder kitula
              //evde blocconsumer use cheydal botht listener and builder kitum
              //listener l naml state l enthelum changes indel ath kanikum
              //builder l ui l enthelum changes ndel ad
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    final emails =_emailController.text;
                   final passwords = _passwordController.text;
                   context.read<AuthCubit>().login(emails,passwords);
                   //login functn laready created..ayle email ,apassword enna parameter n evdethe textfield le adikenna values pass cheyd kodka
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
            )
          ],
        ),
      )),
    );
  }
}
