part of 'app_language_cubit.dart';

@immutable
abstract class AppLanguageState extends Equatable {}

class AppLanguageInitial extends AppLanguageState {
  @override
  List<Object> get props => [];
}

class AppLanguageChange extends AppLanguageState {
  final Locale type;

  AppLanguageChange({this.type});

  @override
  List<Object> get props => [type];
}
