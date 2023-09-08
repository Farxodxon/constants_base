import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_flutter/data_helper.dart';

import '../models/spheres_model.dart';

class SphereCubit extends Cubit<List<Sphere>> {
  List<Sphere> spheres = [];

  SphereCubit():super([]);

  Future<void> getCategoriesData() async {
    final dbHelper = DatabaseHelper.instance;

    // Kategoriyalarni yangilash
    await dbHelper.fetchAndStoreCategories();

    // Kategoriyalarni olish
    final categories = await dbHelper.getCategories();
    spheres = categories;
    emit(categories);

  }
}
