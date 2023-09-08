
class SpheresModel {
  bool? status;
  List<Sphere>? data;

  SpheresModel({this.status, this.data});

  SpheresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Sphere>[];
      json['data'].forEach((v) {
        data!.add(new Sphere.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sphere {
  int? id;
  String? name;
  Description? text;
  String? icon;
  int? count;

  Sphere({this.id, this.name, this.text, this.icon, this.count});

  Sphere.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'] != null ? Description.fromJson(json['text']) : null;
    icon = json['icon'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    data['icon'] = this.icon;
    data['count'] = this.count;
    return data;
  }
}

class Description {
  String? en;
  String? ru;
  String? uz;

  Description({this.en, this.ru, this.uz});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ru = json['ru'];
    uz = json['uz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ru'] = this.ru;
    data['uz'] = this.uz;
    return data;
  }
}