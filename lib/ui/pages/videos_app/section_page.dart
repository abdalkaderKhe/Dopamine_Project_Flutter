import 'package:eisenhower_matrix/ui/pages/videos_app/persons_page.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/subjects_page.dart';
import 'package:eisenhower_matrix/ui/pages/videos_app/tags_page.dart';
import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  @override
  State<Section> createState() => _SectionState();
  String sectionName;
  Section({required this.sectionName});
}

class _SectionState extends State<Section> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                indicatorColor: Colors.black26,
                labelColor: Colors.black,
                labelStyle: const TextStyle(fontFamily: "Almarai",fontSize: 14,color: Colors.black,fontWeight: FontWeight.w100),
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                tabs: const[
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
              controller: _tabController,
              children: [
                PersonsPage(appBarShow: true, sectionName: widget.sectionName,),
                SubjectsPage(appBarShow: false, personName: '', sectionName: widget.sectionName,),
                TagsPage(appBarShow: true, personName: '', sectionName: widget.sectionName,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*
TabBar(
          labelStyle:TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          indicatorColor: Colors.white,
          tabs:const [
            Tab(text: "شخصيات",),
            Tab(text: "الموضوعات",),
            Tab(text: "العناوين",),
          ],
          controller:_tabController,
        ),
 */

/*
TabBarView(
        children:  [
          PersonsPage(appBarShow: true, sectionName: widget.sectionName,),
          SubjectsPage(appBarShow: false, personName: '', sectionName: widget.sectionName,),
          TagsPage(appBarShow: true, personName: '', sectionName: widget.sectionName,),
        ],
        controller: _tabController,
      ),
 */