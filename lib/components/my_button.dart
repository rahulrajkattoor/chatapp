import 'package:flutter/cupertino.dart';

class Mybutton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const Mybutton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CupertinoColors.black
        ),
        child: Text(text,style: TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 16),),
      ),
    );
  }
}
