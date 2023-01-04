class PersonReligionScreenModel{
  late String name,imageUrl,section;
  PersonReligionScreenModel({required this.name,required this.imageUrl,required this.section});


  List<Map> personsMap =
  [
    {
      'section':'الاكتئاب',
      'imageUrl': 'assets/persons/wqewqe.jpg',
      'name':'سعيد رمضان البوطي',
    },
  ];


}



List<PersonReligionScreenModel> personsReligionScreen =[



  PersonReligionScreenModel(
    section:'الاكتئاب',
    imageUrl: 'assets/persons/wqewqe.jpg',
    name: 'سعيد رمضان البوطي',
  ),

];