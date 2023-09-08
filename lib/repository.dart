import 'dart:convert';

import 'package:sqflite_flutter/data_helper.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite_flutter/models/constants_model.dart';
import 'package:sqflite_flutter/models/region_model.dart';
import 'package:sqflite_flutter/models/spheres_model.dart';

class Repository {
  Future<List<Sphere>> fetchCategories() async {
    final response = await http.get(Uri.http('api.jobo.uz', 'v1/categories'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print("get response => $response");
      final data1 = SpheresModel.fromJson(data);
      if (data1.data is List) {
        final List<Sphere> categories = data1.data ?? [];
        return categories;
      } else {
        throw Exception('Invalid data format: Expected a List');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<ConstantaData>> fetchLanguages() async {
    final response = await http.get(Uri.http('api.jobo.uz', 'v1/language'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print("get response => $response");
      final data1 = ConstantsModel.fromJson(data);
      if (data1.data is List) {
        final List<ConstantaData> categories = data1.data ?? [];
        return categories;
      } else {
        throw Exception('Invalid data format: Expected a List');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<RegionData>> fetchRegions() async {
    final response = await http.get(Uri.http('api.jobo.uz', 'v1/location/'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print("get response => $response");
      final data1 = RegionsModel.fromJson(data);
      if (data1.data is List) {
        final List<RegionData> categories = data1.data ?? [];
        return categories;
      } else {
        throw Exception('Invalid data format: Expected a List');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
