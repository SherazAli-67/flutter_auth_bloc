import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_bloc.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_event.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_state.dart';
import 'package:flutter_auth_bloc/src/utils/app_constants.dart';
import 'package:flutter_auth_bloc/src/views/homepage.dart';
import 'package:flutter_auth_bloc/src/views/registerationi_page.dart';
import 'package:flutter_auth_bloc/src/widget/auth_button.dart';
import 'package:flutter_auth_bloc/src/widget/input_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return Scaffold(
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Center(child: Image.asset(icBloC, height: 75,),),
               const Text('Flutter Auth using bloC & Firebase', style: TextStyle(fontWeight: FontWeight.w600),),
               SizedBox(height: size.height*0.2,),
               InputFieldWidget(textEditingController: emailTextController, hintText: 'Enter your email'),
               const SizedBox(height: 20,),
               InputFieldWidget(textEditingController: passwordTextController, hintText: 'Enter your password', isPassword: true,),
               const SizedBox(height: 20,),
               SizedBox(
                   width: size.width*0.7,
                   child: BlocConsumer<AuthBloC, AuthState>(builder: (ctx, state){
                     if(state is AuthLoadingState){
                       return AuthButton(text: 'Loading...', onTap: (){}, isLoading: true,);
                     }else{
                       return AuthButton(text: 'Login', onTap: (){
                         String email = emailTextController.text.trim();
                         String password = passwordTextController.text.trim();
                         context.read<AuthBloC>().add(LoginEvent(email: email, password: password));
                       });
                     }
                   }, listener: (ctx, state){
                     if(state is AuthSuccessState){
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const HomePage()));
                     }else if (state is AuthFailureState){
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to login: ${state.errorMessage}')));
                     }
                   }),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text('Don\'t have account? ', style: TextStyle(fontSize: 14),),
                   InkWell(
                       onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const RegistrationPage())),
                       child: const Text('Register', style: TextStyle(fontSize: 14, color: Colors.purple),))
                 ],
               ),
             ],
           ),
         ),
       ),
     ),
   );
  }
}