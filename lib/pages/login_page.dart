import 'package:chatapp/Service/auth/auth_service.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

  void signIn()async{
    final authService=Provider.of<AuthService>(context,listen: false);
    try{
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    }catch(e){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Center(child: Icon(Icons.message,size: 70,color:Colors.grey.shade800,)),
              SizedBox(height: 20,),

              Text("Welcome back you 've been missed",style: TextStyle(fontSize: 16),),
              SizedBox(height: 50,),
              textfield(Controller: emailController, hintText: "email", obscuretext: false),
              SizedBox(height: 20,),
              textfield(Controller: passwordController, hintText: "password", obscuretext: true),
              SizedBox(height: 30,),
              Mybutton(onTap: signIn, text: "Signin"),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a memmber?"),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                      child: Text("Register now",style: TextStyle(fontWeight: FontWeight.bold),))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
