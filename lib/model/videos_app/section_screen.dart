class SectionReligionScreenModel{
  late String title,imageUrl;
  SectionReligionScreenModel({required this.imageUrl,required this.title});

  List<Map> sectionsMap =
  [
   {'imageUrl':'assets/images/2021_9_16_23_43_47_412.jpg','title': 'الاكتئاب',},
   {'imageUrl':'assets/images/podcast_DAWs-aD31aXfs-DzTechs.jpg','title': 'بودكاست',},
   {'imageUrl':'assets/images/6kxJrhoc_400x400.jpg','title': 'السعادة',},
   {'imageUrl':'assets/images/818x375-171570064707994.jpg','title': 'ادارة الوقت',},
   {'imageUrl':'assets/images/ThinkstockPhotos-154126477-1024x660.jpg','title': 'التسويف',},
   {'imageUrl':'assets/images/dsfsdfsdfdshhhh.jpg','title': 'كتب',},
  ];

}




List<SectionReligionScreenModel> sectionReligionScreenModel = [

  SectionReligionScreenModel(
    imageUrl: 'assets/images/2021_9_16_23_43_47_412.jpg',
    title: 'الاكتئاب',
  ),

  SectionReligionScreenModel(
    imageUrl: 'assets/images/podcast_DAWs-aD31aXfs-DzTechs.jpg',
    title: 'بودكاست',
  ),

  SectionReligionScreenModel(
    imageUrl: 'assets/images/6kxJrhoc_400x400.jpg',
    title: 'السعادة',
  ),

  SectionReligionScreenModel(
    imageUrl: 'assets/images/818x375-171570064707994.jpg',
    title: 'ادارة الوقت',
  ),

  SectionReligionScreenModel(
    imageUrl: 'assets/images/ThinkstockPhotos-154126477-1024x660.jpg',
    title: 'التسويف',
  ),

  SectionReligionScreenModel(
    imageUrl: 'assets/images/dsfsdfsdfdshhhh.jpg',
    title: 'كتب',
  ),

];