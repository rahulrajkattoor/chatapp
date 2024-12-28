import 'package:chatapp/Service/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmpasswordController=TextEditingController();

  void signUp()async{
    if(passwordController.text!=confirmpasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password do not match"))
      );
      return;
    }
    final authService=Provider.of<AuthService>(context,listen: false);
    try{
      await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text);
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

              Text("Create an account",style: TextStyle(fontSize: 16),),
              SizedBox(height: 20,),
              textfield(Controller: emailController, hintText: "email", obscuretext: false),
              SizedBox(height: 10,),
              textfield(Controller: passwordController, hintText: "password", obscuretext: true),
              SizedBox(height: 10,),
              textfield(Controller: confirmpasswordController, hintText: "Confirmpassword", obscuretext: true),
              SizedBox(height: 30,),
              Mybutton(onTap: signUp, text: "Signup"),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a memmber?"),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                      child: Text("Login now",style: TextStyle(fontWeight: FontWeight.bold),))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
