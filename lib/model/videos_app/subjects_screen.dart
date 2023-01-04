class SubjectsReligionScreenModel{
  late String title,imageUrl,personName,sectionName;
  SubjectsReligionScreenModel({required this.imageUrl,required this.title,required this.personName,required this.sectionName});
  List<Map> subjectsMap =
  [
    {
      'title':'الكآبة',
      'personName': 'سعيد رمضان البوطي',
      'sectionName':'الاكتئاب',
      'imageUrl':'assets/subjects/maxresdefault255.jpg',
    },
  ];

}

List<SubjectsReligionScreenModel> subjectsReligionScreenModel = [

  SubjectsReligionScreenModel(
    title: 'الكآبة',
    personName: 'سعيد رمضان البوطي',
    sectionName: 'الاكتئاب',
    imageUrl: 'assets/subjects/maxresdefault255.jpg',
  ),


];