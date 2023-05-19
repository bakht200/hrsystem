part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {}

class AuthenticationUserNotFound extends AuthenticationState {}

class AuthenticationPasswordError extends AuthenticationState {}

class AuthenticationInternetError extends AuthenticationState {}
