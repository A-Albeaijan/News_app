import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'cahechHelper/cachhelper.dart';
import 'newsapp/cubit/cubit.dart';
import 'newsapp/cubit/state.dart';
import 'newsapp/dio/dioHelper.dart';
import 'newsapp/layout.dart';
import 'newsapp/models/search/searchScreen.dart';
import 'newsapp/models/webview/webviewScreen.dart';
import 'newsapp/observer.dart';

void main() async {
  //for async main, to make sure that the await if done, then run the app
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isdark = CacheHelper.getData('isdark');
  runApp(MyApp(isdark));
}

class MyApp extends StatelessWidget {
  MyApp(this.isdark);
  final bool? isdark;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..changeAppMode(value: isdark),
      child: BlocConsumer<NewsCubit, newsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black87,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 30,
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('242526'),
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('242526'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('242526'),
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('242526'),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 30,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isdark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayout(),
            routes: {
              'search': (context) => SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
