import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_flutter/data_helper.dart';
import 'package:sqflite_flutter/models/region_model.dart';

import '../models/spheres_model.dart';

class RegionCubit extends Cubit<List<RegionData>> {
  List<RegionData> spheres = [];

  RegionCubit():super([]);

  Future<void> getRegionsData() async {
    final dbHelper = DatabaseHelper.instance;

    // Kategoriyalarni yangilash
    await dbHelper.fetchAndStoreRegions();

    // Kategoriyalarni olish
    final categories = await dbHelper.getRegions();
    spheres = categories;
    emit(categories);

  }
}
