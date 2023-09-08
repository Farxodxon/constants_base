import 'package:sqflite_flutter/models/spheres_model.dart';

class ConstantsModel {
  bool? status;
  List<ConstantaData>? data;

  ConstantsModel({this.status, this.data});

  ConstantsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ConstantaData>[];
      json['data'].forEach((v) {
        data!.add(ConstantaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConstantaData {
  int? id;
  String? name;
  Description? text;
  String? createdAt;
  String? updatedAt;

  ConstantaData({this.id, this.name, this.text, this.createdAt, this.updatedAt});

  ConstantaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['text'] != null ? Description.fromJson(json['text']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (text != null) {
      data['text'] = text!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
