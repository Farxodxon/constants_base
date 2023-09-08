class RegionsBase {
  int? slug;
  String? title;
  int? parentSlug;
  String? textUz;
  String? textRu;
  String? textEn;

  RegionsBase({
    this.slug,
    this.title,
    this.parentSlug,
    this.textUz,
    this.textRu,
    this.textEn,
  });

  RegionsBase.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    parentSlug = json['parentSlug'];
    title = json['title'];
    textUz = json['textUz'];
    textRu = json['textRu'];
    textEn = json['textEn'];
  }
}
