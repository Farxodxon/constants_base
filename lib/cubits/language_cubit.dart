import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_flutter/data_helper.dart';
import 'package:sqflite_flutter/models/constants_model.dart';


class LanguageCubit extends Cubit<List<ConstantaData>> {
  List<ConstantaData> languages = [];

  LanguageCubit():super([]);

  Future<void> getLanguageData() async {
    final dbHelper = DatabaseHelper.instance;

    // Kategoriyalarni yangilash
    await dbHelper.fetchAndStoreLanguages();

    // Kategoriyalarni olish
    final languageList = await dbHelper.getLanguages();
    languages = languageList;
    emit(languageList);

  }
}
