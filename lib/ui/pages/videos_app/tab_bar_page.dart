import 'package:eisenhower_matrix/ui/pages/videos_app/persons_page.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/subjects_page.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/tags_page.dart';
import 'package:flutter/material.dart';

import 'sections_page.dart';
class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);
  @override
  State<TabBarPage> createState() => _TabBarPageState();
}
class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin{

  late TabController _tabControllerApp;

  @override
  void initState() {
    super.initState();
    _tabControllerApp = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabControllerApp.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
              labelStyle: const TextStyle(fontFamily: "Almarai",fontSize: 13,color: Colors.black,fontWeight: FontWeight.w100),
              indicatorColor: Colors.black26,
              labelColor: Colors.black,
              controller: _tabControllerApp,
              unselectedLabelColor: Colors.grey,
              tabs: const[
                Tab(text: "الأقسام",),
                Tab(text: "شخصيات",),
                Tab(text: "الموضوعات",),
                Tab(text: "العناوين",),
              ],
             ),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: size.height * 0.87,
            child: TabBarView(
            controller: _tabControllerApp,
            children: [
              SectionsPage(appBarShow: false),
              PersonsPage(appBarShow: false, sectionName: '',),
              SubjectsPage(appBarShow: false, personName: '', sectionName: '',),
              TagsPage(appBarShow: false, sectionName: '', personName: '',),
            ],
          ),
          ),
        ],
      ),
    );
  }

}





/*
      /*
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        //title: const Text("محتوى خاص بتطوير الذات",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
       // actions: [
          //IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
      //  ],
        bottom: TabBar(
          labelStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
          indicatorColor: Colors.white,

          tabs:const [
            Tab(text: "الأقسام",),
            Tab(text: "شخصيات",),
            Tab(text: "الموضوعات",),
            Tab(text: "العناوين",),
          ],
          controller:_tabControllerApp,
        ),
      ),
       */
      //drawer: const Drawer(),
      /*
      body: TabBarView(
        controller: _tabControllerApp,
        children: [
          SectionsScreen(appBarShow: false),
          PersonsScreen(appBarShow: false, sectionName: '',),
          SubjectsScreen(appBarShow: false, personName: '', sectionName: '',),
          TagsScreen(appBarShow: false, sectionName: '', personName: '',),
        ],
      ),
       */
 */