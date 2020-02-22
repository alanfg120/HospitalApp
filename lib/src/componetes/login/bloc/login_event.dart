part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthEvent extends LoginEvent {
  final Usuario usuario;
  AuthEvent({this.usuario});
  @override
  List<Object> get props => [usuario];
}

class RegistroEvent extends LoginEvent {
  final Usuario usuario;
  RegistroEvent({this.usuario});
  @override
  List<Object> get props => [usuario];
}

class LogOutEvent extends LoginEvent{}

class VericarLoginEvent extends LoginEvent{}