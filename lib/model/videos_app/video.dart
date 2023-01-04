class VideoModel{
  late String title,url,subject,person_name,sectionName;
  late List<String> tags;
  VideoModel({required this.title,required this.url,required this.subject,required this.person_name,required this.tags,required this.sectionName});
  List<Map> videosMap =
  [
    {
      'tags' : ['السعادة','الاكتئاب'],
      'person_name': 'سعيد رمضان البوطي',
      'url': 'https://www.youtube.com/watch?v=1xGzpXE68PM',
      'sectionName':'الاكتئاب',
      'subject':'الكآبة',
      'title': 'العوامل الكامنة وراء آفة الكآبة',
    },
  ];
}

List<VideoModel> videos = [



  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'العوامل الكامنة وراء آفة الكآبة',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=1xGzpXE68PM',
    sectionName: 'الاكتئاب',
  ),

  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'السبب الأول : جهل حقيقة الحياة',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=qTWPYlIy4S0',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'السبب الثاني : الخوف من الإخفاق',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=NZhSO9vjRw0',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'السبب الثالث : الخوف من المصائب',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=wYNIQlRGZVY',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'صورة خطيرة من الخوف من المصائب',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=cgxO-FGo8ek',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'السبب الرابع : الخوف من الموت',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=oAX6ylTz9G4',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'السبب الخامس : الشعور بالعجز عن بلوغ الآمال والطموحات',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=VQUZLMesIG8',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'العلاج من الكآبة : علاج معرفي وعلاج عملي',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=ZLp2T_c4GGU',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'العلاج من الكآبة : علاج معرفي وعلاج عملي',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=oWa0SSMIpiQ',
    sectionName: 'الاكتئاب',
  ),
  VideoModel(
    tags: ['السعادة','الاكتئاب'],
    person_name: 'سعيد رمضان البوطي',
    title: 'هل يكون السحر سبباً من أسباب الكآبة ؟',
    subject:'الكآبة',
    url: 'https://www.youtube.com/watch?v=F8fHdBSDak4',
    sectionName: 'الاكتئاب',
  ),

];