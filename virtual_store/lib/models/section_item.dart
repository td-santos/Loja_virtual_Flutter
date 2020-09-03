class SectionItem{

  String image;

  SectionItem.fromMap(Map<String,dynamic> map){
    image = map['image'] as String;
  }

  String toString(){
    return  'SectionItem{image: $image}';
  }
}