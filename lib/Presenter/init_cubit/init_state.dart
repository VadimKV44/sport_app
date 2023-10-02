part of 'init_cubit.dart';

@immutable
abstract class InitState {}

class InitInitial extends InitState {}

class Loading extends InitState {}

class Success extends InitState {}

class Error extends InitState {}

