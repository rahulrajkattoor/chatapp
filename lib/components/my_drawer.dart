import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
          Column(

            children: [
              DrawerHeader(child: Icon(Icons.message,color: Theme.of(context).colorScheme.primary,size: 64,),),
              Padding(
                padding: const EdgeInsets.only(left: 25,),
                child: ListTile(title: Text("H O M E"),leading: Icon(Icons.home),
                onTap: (){
                  Navigator.pop(context);
                },),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,),
                child: ListTile(title: Text("S E T T I N G "),leading: Icon(Icons.settings,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                },),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,top: 300),
                child: ListTile(title: Text("L O G O U T"),leading: Icon(Icons.settings),
                onTap: signOut,),
              )

            ],
          ),


    );
  }
}
