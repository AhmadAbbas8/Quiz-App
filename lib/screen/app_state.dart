part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class ChangeCurrentPageInText extends AppState {}
class DisplayIconOfAns extends AppState {}
class UpdateProgressTimer extends AppState {}
