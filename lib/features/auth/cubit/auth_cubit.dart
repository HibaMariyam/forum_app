
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/common/models/user.dart';
import 'package:forum_app/common/utils/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
void login(String email,String password)async{
  emit(AuthLoading());
 try {
   final resp = await dioClient.post('/login/',
   //dioclient l already baseurl kodthkn..ad ellatinum same aan..so baki mati kodtha mathy../login aan login nted..pinne post method use cheyd ayond post kodkum evde
   data: {
    'username': email,
    'password': password
   }
   );
   final sharedPref = await SharedPreferences.getInstance();
   //sharredpref package used for storing in our device storage 
   await sharedPref.setString('token', resp.data['token']);
   //'token' n parynad naml oru key name kodkan..ad enthum kodka..ennt aynte value ayt namle rsp.data l oroninum oru token value ndavum lik e'token:232453524'..edeele ee oro token value evde access cheyum
   emit(AuthSuccess(Users.fromJson(resp.data)));
 } catch (e) {
   emit(AuthFailure(e.toString()));
 }

}
//Instead of blocking the code execution until the HTTP request is complete, await allows the code to continue executing other tasks while waiting for the HTTP request to finish.
//resp will hold the result of the HTTP request once it's complete.
//By using async and await, you are writing asynchronous code that won't block the execution of your program while waiting for time-consuming tasks, such as making a network request. 

//loaduser funct naml app start chyumbonne vilkum
//already ee token compare cheydt mnunne oru user login vhyedad ndo nokaanan ad..
//ndenkl nere homepage k load cheyum
void loadUser()async{
emit(AuthLoading());
try {
  final sharedPref= await SharedPreferences.getInstance();
  final token = sharedPref.getString('token');
  final resp = await dioClient.get('/profile/',
  //get reqst aykumbo naml token kodkanam.ayn lladan optns l header l authoruzatn angne kodknad
  options: Options(headers: {'Authorization':'Token ${token}'}));
  //$token means out token value..eg:26352634239493457385
  resp.data['token']=token;
  //login loke llad pole profile l namk token n parna key lla
  //but accrdng to our model class token venam..
  //so profile k data k naml token n parna oru key add cheyd..aynte value akeet nerth =e naml token value store cheydtla 'token' ayk kodkum
  emit(AuthSuccess(Users.fromJson(resp.data)));
} catch (e) {
  emit(AuthInitial());
  //f there is an error during the asynchronous operations (e.g., network error, parsing error), it catches the exception and emits an initial state (AuthInitial). This may indicate that the authentication state should be reset or reinitialized.
}
}
void logOut()async{
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.remove('token');
}
}
