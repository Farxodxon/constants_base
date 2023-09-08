class SphereBase {
  int? slug;
  String? name;
  String? textUz;
  String? textRu;
  String? textEn;
  String? icon;
  int? count;

  SphereBase(
      {this.slug,
      this.name,
      this.textUz,
      this.textRu,
      this.textEn,
      this.icon,
      this.count});

  SphereBase.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    textUz = json['textUz'];
    textRu = json['textRu'];
    textEn = json['textEn'];
    icon = json['icon'];
    count = json['count'];
  }
}
