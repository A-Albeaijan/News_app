abstract class newsState {}

class NewsinitiakState extends newsState {}

class NewsbuttomNabState extends newsState {}

class NewsGetBusinessLoadingState extends newsState {}

class NewsGetBusinessSucessState extends newsState {}

class NewsGetBusinessErrorState extends newsState {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportLoadingState extends newsState {}

class NewsGetSportSucessState extends newsState {}

class NewsGetSportErrorState extends newsState {
  final String error;
  NewsGetSportErrorState(this.error);
}

class NewsGetScienceLoadingState extends newsState {}

class NewsGetScienceSucessState extends newsState {}

class NewsGetScienceErrorState extends newsState {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class ChangeModeState extends newsState {}

class NewsGetSearchLoadingState extends newsState {}

class NewsGetSearchSucessState extends newsState {}

class NewsGetSearchErrorState extends newsState {
  final String error;
  NewsGetSearchErrorState(this.error);
}
