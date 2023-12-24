import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_bloc.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_event.dart';
import 'package:flutter_auth_bloc/src/bloc/auth_state.dart';
import 'package:flutter_auth_bloc/src/utils/app_constants.dart';
import 'package:flutter_auth_bloc/src/views/homepage.dart';
import 'package:flutter_auth_bloc/src/views/login_page.dart';
import 'package:flutter_auth_bloc/src/widget/auth_button.dart';
import 'package:flutter_auth_bloc/src/widget/input_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Column(
                 children: [
                   Center(child: Image.asset(icBloC, height: 75,),),
                   const Text('Flutter Auth using bloC & Firebase', style: TextStyle(fontWeight: FontWeight.w600),),
                 ],
               ),
                const SizedBox(height: 40,),
                const Text('Registration Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                SizedBox(height: size.height*0.2,),
                InputFieldWidget(textEditingController: emailTextController, hintText: 'Enter your email'),
                const SizedBox(height: 20,),
                InputFieldWidget(textEditingController: passwordTextController, hintText: 'Enter your password', isPassword: true,),
                SizedBox(height: size.height*0.1,),

                Center(
                  child: SizedBox(
                      width: size.width*0.7,
                      child: BlocConsumer<AuthBloC, AuthState>(builder: (ctx, state){
                        if(state is AuthInitialState){
                          return AuthButton(text: 'Sign up', onTap: (){
                            String email = emailTextController.text.trim();
                            String password = passwordTextController.text.trim();
                            context.read<AuthBloC>().add(SignupEvent(email: email, password: password));
                          });
                        }
                        else if(state is AuthLoadingState){
                          return AuthButton(text: 'Loading...', onTap: (){}, isLoading: true,);
                        } else{
                          return AuthButton(text: 'Sign up', onTap: (){
                            String email = emailTextController.text.trim();
                            String password = passwordTextController.text.trim();
                            context.read<AuthBloC>().add(SignupEvent(email: email, password: password));
                          });
                        }
                      }, listener: (ctx, state){
                        if(state is AuthFailureState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to signup: ${state.errorMessage}')));
                        } else if(state is AuthSuccessState){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const HomePage()));
                        }
                      }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ', style: TextStyle(fontSize: 14),),
                    InkWell(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const LoginPage())),
                        child: const Text('Login', style: TextStyle(fontSize: 14, color: Colors.purple),))
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}