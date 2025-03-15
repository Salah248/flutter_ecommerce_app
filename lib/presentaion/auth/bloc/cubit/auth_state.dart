part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucess extends AuthState {}

final class AuthFailure extends AuthState {
   final String errMessage;

  AuthFailure(this.errMessage); 

}


final class UserDataLoading extends AuthState {}

final class UserDataSucess extends AuthState {}

final class UserDataFailure extends AuthState {
   final String errMessage;

  UserDataFailure(this.errMessage); 

}
final class FetchUserDataLoading extends AuthState {}

final class FetchUserDataSucess extends AuthState {}

final class FetchUserDataFailure extends AuthState {
   final String errMessage;

  FetchUserDataFailure(this.errMessage); 

}