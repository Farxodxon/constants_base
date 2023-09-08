import 'package:sqflite_flutter/models/spheres_model.dart';

class RegionsModel {
  bool? status;
  List<RegionData>? data;

  RegionsModel({this.status, this.data});

  RegionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <RegionData>[];
      json['data'].forEach((v) {
        data!.add(RegionData.fromJson(v));
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

class RegionData {
  int? id;
  String? title;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  Description? name;

  RegionData(
      {this.id,
        this.title,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.name});

  RegionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'] != null ? Description.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
  }
}
