part of 'app_theme_cubit.dart';

@immutable
abstract class AppThemeState extends Equatable {}

class AppThemeInitial extends AppThemeState {
  @override
  List<Object> get props => [];
}

class AppThemeChange extends AppThemeState {
  final bool isDark;

  AppThemeChange({this.isDark});

  @override
  List<Object> get props => [isDark];
}
