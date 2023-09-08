import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_flutter/models/constanta_base.dart';
import 'package:sqflite_flutter/models/constants_model.dart';
import 'package:sqflite_flutter/models/region_base.dart';
import 'package:sqflite_flutter/models/region_model.dart';
import 'package:sqflite_flutter/models/sphere_base.dart';
import 'package:sqflite_flutter/models/spheres_model.dart';
import 'package:sqflite_flutter/repository.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  final repository = Repository();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'jobo.db');
    print("Path: $path");
    final db=await openDatabase(
        'db.sqlite',
        version: 1,
        onCreate: (db, version) {
          _createDatabaseSpheres(db,version);
          _createDatabaseLanguages(db,version);
          _createDatabaseRegions(db,version);
        },
        onUpgrade: (db, oldVersion, newVersion) {
            _createDatabaseSpheres(db,newVersion);
            _createDatabaseLanguages(db,newVersion);
            _createDatabaseRegions(db,newVersion);
        }
    );
    _createDatabaseSpheres(db,1);
    _createDatabaseLanguages(db,1);
    _createDatabaseRegions(db,1);

    return db;
  }


  //spheres

  Future<void> _createDatabaseSpheres(Database db, int version) async {
    await db.execute('''
     CREATE TABLE spheres (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug INTEGER,
  name TEXT,
  textUz TEXT,
  textRu TEXT,
  textEn TEXT,
  icon TEXT,
  count INTEGER
)
    ''');
  }

  Future<void> insertCategories(List<Sphere> categories) async {
    final db = await database;
    final batch = db.batch();
    categories.forEach((category) {
      batch.insert('spheres', {
        'slug': category.id,
        'name': category.name,
        'textUz': category.text?.uz,
        'textRu': category.text?.ru,
        'textEn': category.text?.en,
        'icon': category.icon,
        'count': category.count,
      });
    });
    await batch.commit();
  }

  Future<List<Sphere>> getCategories() async {
    List<Sphere> list = [];
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('spheres');
    for (int i = 0; i < maps.length; i++) {
      list.add(Sphere(
        id: SphereBase.fromJson(maps[i]).slug,
        name: SphereBase.fromJson(maps[i]).name,
        count: SphereBase.fromJson(maps[i]).count,
        icon: SphereBase.fromJson(maps[i]).icon,
        text: Description(
          uz: SphereBase.fromJson(maps[i]).textUz,
          ru: SphereBase.fromJson(maps[i]).textRu,
          en: SphereBase.fromJson(maps[i]).textEn,
        ),
      ));
    }
    return list;
  }

  Future<void> clearCategories() async {
    final db = await database;
    await db.delete('spheres');
  }

  Future<void> fetchAndStoreCategories() async {
    await clearCategories();
    await insertCategories(await repository.fetchCategories());
  }

  //

  Future<void> _createDatabaseLanguages(Database db, int version) async {
    await db.execute('''
     CREATE TABLE languages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug INTEGER,
  name TEXT,
  textUz TEXT,
  textRu TEXT,
  textEn TEXT
)
    ''');
  }

  Future<void> insertLanguages(List<ConstantaData> categories) async {
    final db = await database;
    final batch = db.batch();
    categories.forEach((language) {
      batch.insert('languages', {
        'slug': language.id,
        'name': language.name,
        'textUz': language.text?.uz,
        'textRu': language.text?.ru,
        'textEn': language.text?.en,
      });
    });
    await batch.commit();
  }

  Future<List<ConstantaData>> getLanguages() async {
    List<ConstantaData> list = [];
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('languages');
    for (int i = 0; i < maps.length; i++) {
      list.add(ConstantaData(
        id: ConstantsBase.fromJson(maps[i]).slug,
        name: ConstantsBase.fromJson(maps[i]).name,
        text: Description(
          uz: ConstantsBase.fromJson(maps[i]).textUz,
          ru: ConstantsBase.fromJson(maps[i]).textRu,
          en: ConstantsBase.fromJson(maps[i]).textEn,
        ),
      ));
    }
    return list;
  }

  Future<void> clearLanguages() async {
    final db = await database;
    await db.delete('languages');
  }

  Future<void> fetchAndStoreLanguages() async {
    await clearLanguages();
    await insertLanguages(await repository.fetchLanguages());
  }
  //regions

  Future<void> _createDatabaseRegions(Database db, int version) async {
    await db.execute('''
     CREATE TABLE regions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug INTEGER,
  title TEXT,
  parentSlug INTEGER,
  textUz TEXT,
  textRu TEXT,
  textEn TEXT
)
    ''');
  }

  Future<void> insertRegions(List<RegionData> categories) async {
    final db = await database;
    final batch = db.batch();
    categories.forEach((regions) {
      batch.insert('regions', {
        'slug': regions.id,
        'title':regions.title,
        'parentSlug':regions.parentId,
        'textUz': regions.name?.uz,
        'textRu': regions.name?.ru,
        'textEn': regions.name?.en,
      });
    });
    await batch.commit();
  }

  Future<List<RegionData>> getRegions() async {
    List<RegionData> list = [];
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('regions');
    for (int i = 0; i < maps.length; i++) {
      list.add(RegionData(
        id: RegionsBase.fromJson(maps[i]).slug,
        title: RegionsBase.fromJson(maps[i]).title,
        parentId: RegionsBase.fromJson(maps[i]).parentSlug,
        name: Description(
          uz: RegionsBase.fromJson(maps[i]).textUz,
          ru: RegionsBase.fromJson(maps[i]).textRu,
          en: RegionsBase.fromJson(maps[i]).textEn,
        ),
      ));
    }
    return list;
  }

  Future<void> clearRegions() async {
    final db = await database;
    await db.delete('regions');
  }

  Future<void> fetchAndStoreRegions() async {
    await clearRegions();
    await insertRegions(await repository.fetchRegions());
  }
}


