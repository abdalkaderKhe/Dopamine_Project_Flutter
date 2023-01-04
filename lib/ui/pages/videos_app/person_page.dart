import 'package:eisenhower_matrix/ui/pages/videos_app/tags_page.dart';
import 'package:flutter/material.dart';

import 'subjects_page.dart';
class PersonScreen extends StatefulWidget {
  @override
  State<PersonScreen> createState() => _PersonScreenState();
  String personName;
  PersonScreen({required this.personName});
}
class _PersonScreenState extends State<PersonScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        title: const Text("اسم الشخصية",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],

        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "الموضوعات",),
            Tab(text: "العناوين",),
          ],
          controller: _tabController,),

      ),
       */
      //drawer: Drawer(),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorColor: Colors.black26,
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontFamily: "Almarai",fontSize: 14,color: Colors.black,fontWeight: FontWeight.w100),
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                tabs: const[
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
              controller: _tabController,
              children: [
                SubjectsPage(appBarShow: false, personName: widget.personName, sectionName: '',),
                TagsPage(appBarShow: false, sectionName: '', personName: widget.personName,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
TabBarView(
        children: [
          SubjectsPage(appBarShow: false, personName: widget.personName, sectionName: '',),
          TagsPage(appBarShow: false, sectionName: '', personName: widget.personName,),
        ],
        controller: _tabController,
      ),
 */