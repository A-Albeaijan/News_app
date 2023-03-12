import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/newsapp/cubit/state.dart';

import '../../cahechHelper/cachhelper.dart';
import '../dio/dioHelper.dart';
import '../models/buss/bussSren.dart';
import '../models/settings/settingsSeren.dart';
import '../models/siecnce/sienceScreen.dart';
import '../models/sports/sportScren.dart';

class NewsCubit extends Cubit<newsState> {
  NewsCubit() : super(NewsinitiakState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
  ];

  List<Widget> screens = const [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    SettingsScreen(),
  ];

  void ChangeBottmNavBar(index) {
    currentindex = index;
    if (index == 1) {
      getSportData();
    }
    if (index == 2) {
      getScienceData();
    }
    emit(NewsbuttomNabState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'sa',
      'category': 'business',
      'apiKey': 'aa34671f29a74a96b0189f856b9db9cf'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['urlToImage']);
      emit(NewsGetBusinessSucessState());
    }).catchError((error) {
      print('Error at geting data ${error}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> Sports = [];

  void getSportData() {
    if (Sports.length == 0) {
      emit(NewsGetSportLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'sa',
        'category': 'sports',
        'apiKey': 'aa34671f29a74a96b0189f856b9db9cf'
      }).then((value) {
        // print(value.data['articles'][0]['title']);
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(NewsGetSportSucessState());
      }).catchError((error) {
        print('Error at geting data ${error}');
        emit(NewsGetSportErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportSucessState());
    }
  }

  List<dynamic> science = [];

  void getScienceData() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'sa',
        'category': 'science',
        'apiKey': 'aa34671f29a74a96b0189f856b9db9cf'
      }).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        print('Error at geting data ${error}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

  bool isdark = false;

  void changeAppMode({bool? value}) {
    if (value != null) {
      isdark = value;
      emit(ChangeModeState());
    } else {
      isdark = !isdark;
      CacheHelper.putData('isdark', isdark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  List<dynamic> searchResult = [];

  void getSearch(String value) {
    //to make the list empty if the user enter something new
    searchResult = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '${value}',
      'apiKey': 'aa34671f29a74a96b0189f856b9db9cf'
    }).then((value) {
      // print(value.data['articles'][0]['title']);
      searchResult = value.data['articles'];
      print(searchResult[0]['title']);
      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      print('Error at geting data ${error}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
