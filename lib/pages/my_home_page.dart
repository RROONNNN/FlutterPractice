
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/assets/app_colors.dart' as AppColors;

import '../app_tab.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  List popularBooks = [];
  late ScrollController  _scrollController;
  late TabController _tabController;
  ReadData() async{
   await DefaultAssetBundle.of(context).loadString('json/book.json').then((value) {

      setState((){
        popularBooks = json.decode(value);
        print(popularBooks);
      });
    }

    );
  }
  @override
  void initState(){
    ReadData();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.background,
      child:  SafeArea(
        child:Scaffold(
               body: Scaffold(
                 body:Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.only(left:20,right:20) ,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           ImageIcon(AssetImage("assets/images/menu.png"), size: 24,color: Colors.black),
                           Row(
                             children: [
                               Icon(Icons.search),
                               SizedBox(width: 10,),
                               Icon(Icons.notifications)
                             ],
                           )
                       
                         ],
                       ),
                     ),


                     Align(
                       alignment: Alignment.centerLeft,
                       child: Container(
                         margin:const EdgeInsets.only(left:20),
                         child:Text("Popular Books",style: TextStyle(fontSize: 30),),
                       ),
                     ),
                     Container(
                       height: 200,
                       child: Stack(
                         children: [
                           Positioned(
                             left:-20,
                             top: 0,
                             right: 0,
                             child: Container(
                                 height: 180,
                                 child:PageView.builder(
                                     controller: PageController(viewportFraction:0.8),
                                      itemCount: popularBooks.length,
                                     itemBuilder: (_,i){
                                   return Container(
                                     margin: const EdgeInsets.only(right: 10),
                                     height: 180,
                                     width: MediaQuery.of(context).size.width,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         image: DecorationImage(
                                           image:AssetImage(popularBooks[i]['img']),
                                           fit: BoxFit.cover
                                         )
                                     ),
                                   );
                                 })
                             ),
                           ),
                         ],
                       ),
                     ),
                     Expanded(child: NestedScrollView(controller: _scrollController,
                         headerSliverBuilder: (BuildContext context, bool isScroll){

                       return [SliverAppBar(
                              pinned: true,
                         bottom:PreferredSize(preferredSize: Size.fromHeight(50) ,
                             child: Container(
                               margin: const EdgeInsets.only(bottom: 20),
                               child: TabBar(
                                 indicatorPadding: EdgeInsets.all(0),
                                 indicatorSize: TabBarIndicatorSize.label,
                                 labelPadding: const EdgeInsets.only(right:10),
                                 controller: _tabController,
                                 isScrollable: true,
                                 indicator: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 7,
                                        offset: Offset(0, 0)
                                      )
                                   ]
                                 ), tabs: [
                                 AppTab(title: "New", color: AppColors.menu1Color),
                         AppTab(title: "Popular", color: AppColors.menu2Color),
                                 AppTab(title: "Trending", color: AppColors.menu3Color),
                               ],
                               ),
                             ))
                       )];
                         },
                         body: TabBarView(   //content
                             controller: _tabController,
                             children: [
                                ListView.builder(itemBuilder: (_,i){
                                   return Container(

                                     margin: const EdgeInsets.all(10),
                                     child:Container(
                                        padding: const EdgeInsets.all(8),
                                       decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                         color: Colors.white,
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.grey.withOpacity(0.2),
                                             blurRadius: 7,
                                             offset: Offset(0, 0)
                                           )
                                         ]
                                       ),
                                       child: Row(
                                         children: [
                                           Container(
                                              height: 120,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: AssetImage(popularBooks[i]['img']),
                                                )
                                              ),
                                           ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.stars,size: 24,color: AppColors.starColor,),
                                                    SizedBox(width: 5,),
                                                    Text(popularBooks[i]['rating'],style:TextStyle(color: AppColors.menu1Color)),
                                                  ],
                                                ),
                                                Text(popularBooks[i]['title'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text(popularBooks[i]['text'],style: TextStyle(color: AppColors.subTitleText),),
                                                Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: AppColors.loveColor
                                                  ),
                                                  child:Text("Love",style: TextStyle(color: Colors.white,fontSize: 12),),
                                                )
                                              ],
                                            ),

                                         ],
                                       ),
                                     )
                                   );
                                                  },
                                                           itemCount: popularBooks.length,

                                                           ),
                           Material(
                             child: ListTile(
                               leading:CircleAvatar(
                                 backgroundColor: Colors.grey,

                               ),
                               title: Text("Content"),
                             ),
                           ),
                           Material(
                             child: ListTile(
                               leading:CircleAvatar(
                                 backgroundColor: Colors.grey,
                               ),
                               title: Text("Content"),
                             ),
                           ),

                         ])))

                   ],
                 )
               )
        )
      )
    );
  }
}
