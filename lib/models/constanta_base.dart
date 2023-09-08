class ConstantsBase {
  int? slug;
  String? name;
  String? textUz;
  String? textRu;
  String? textEn;


  ConstantsBase(
      {this.slug,
        this.name,
        this.textUz,
        this.textRu,
        this.textEn,
       });

  ConstantsBase.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    textUz = json['textUz'];
    textRu = json['textRu'];
    textEn = json['textEn'];
  }
}
