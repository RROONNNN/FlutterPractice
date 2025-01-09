import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/assets/app_colors.dart' as AppColors;
class AppTab extends StatelessWidget{
  final String title;
  final Color color;
  const AppTab({super.key, required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
   return     Container(
     alignment: Alignment.center,
     width:120,
     height: 50,
     child:Text(
       title,
       style: TextStyle(
           color: Colors.white,
           fontSize: 20
       ),
     ),
     decoration: BoxDecoration(
         color: color,
         borderRadius: BorderRadius.circular(10),
         boxShadow:[
           BoxShadow(
             color: Colors.grey.withOpacity(0.3),
           )
         ]
     ),
   );
  }

}