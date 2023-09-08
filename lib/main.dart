import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite_flutter/cubits/language_cubit.dart';
import 'package:sqflite_flutter/cubits/region_cubit.dart';
import 'package:sqflite_flutter/cubits/spheres_cubit.dart';
import 'package:sqflite_flutter/data_helper.dart';
import 'package:sqflite_flutter/models/constants_model.dart';
import 'package:sqflite_flutter/models/spheres_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SphereCubit>(create: (_) => SphereCubit()),
            BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
            BlocProvider<RegionCubit>(create: (_) => RegionCubit()),
          ],
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  final sphereCubit = SphereCubit();
  final languageCubit = LanguageCubit();
  final regionCubit = RegionCubit();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Constants List"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //1
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: BlocBuilder<SphereCubit, List<Sphere>>(
                builder: (context, count) => FutureBuilder(
                  future: sphereCubit.getCategoriesData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: sphereCubit.state.length,
                          itemBuilder: (context, index) {
                            return getItem(
                                sphereCubit.state[index].icon,
                                null,
                                sphereCubit.state[index].id.toString(),
                                sphereCubit.state[index].name ?? '',
                                sphereCubit.state[index].text?.uz ?? '',
                                sphereCubit.state[index].text?.en ?? '',
                                sphereCubit.state[index].text?.ru ?? '') ;
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
//2
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: BlocBuilder<LanguageCubit, List<ConstantaData>>(
                builder: (context, count) => FutureBuilder(
                  future: languageCubit.getLanguageData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: languageCubit.state.length,
                          itemBuilder: (context, index) {
                            return getItem(
                                null,
                                null,
                                languageCubit.state[index].id.toString(),
                                languageCubit.state[index].name ?? '',
                                languageCubit.state[index].text?.uz ?? '',
                                languageCubit.state[index].text?.en ?? '',
                                languageCubit.state[index].text?.ru ?? '');
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
//3
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: BlocBuilder<SphereCubit, List<Sphere>>(
                builder: (context, count) => FutureBuilder(
                  future: regionCubit.getRegionsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: regionCubit.state.length,
                          itemBuilder: (context, index) {
                            return getItem(
                              null,
                              regionCubit.state[index].parentId.toString(),
                              regionCubit.state[index].id.toString(),
                              regionCubit.state[index].title ?? '',
                              regionCubit.state[index].name?.uz ?? '',
                              regionCubit.state[index].name?.en ?? '',
                              regionCubit.state[index].name?.ru ?? '',
                            ) ;
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String truncateText1(String text) {
    if (text.length > 20) {
      text = "${text.substring(0, 20)}...";
    }
    return text;
  }

  Widget getItem(
    String? icon,
    String? parentId,
    String id,
    String name,
    String uz,
    String en,
    String ru,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Row(
            children: [
              icon != null
                  ? CircleAvatar(
                      radius: 35,
                      child: SvgPicture.string(
                        icon,
                        width: 35,
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 parentId!=null? Row(
                    children: [
                      Text("parent id: "),
                      Text(parentId ?? ''),
                    ],
                  ):SizedBox(),
                  Row(
                    children: [
                      Text("id: "),
                      Text(id ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      Text("name: "),
                      Text(truncateText1(name ?? '')),
                    ],
                  ),
                  Row(
                    children: [
                      Text("uz: "),
                      Text(
                        truncateText1(uz ?? ''),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("en: "),
                      Text(
                        truncateText1(en ?? ''),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("ru: "),
                      Text(
                        truncateText1(ru ?? ''),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
