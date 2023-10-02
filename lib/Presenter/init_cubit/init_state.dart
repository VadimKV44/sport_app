part of 'init_cubit.dart';

@immutable
abstract class InitState {}

class InitInitial extends InitState {}

class Loading extends InitState {}

class ShowWebView extends InitState {}

class Error extends InitState {}

class ShowPlug extends InitState {}