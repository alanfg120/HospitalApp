part of 'login_bloc.dart';

class LoginState extends Equatable {
  final Usuario usuario;

  LoginState({this.usuario});

  factory LoginState.initial() => LoginState(
        usuario: Usuario(password: '', email: '', nombre: '', cedula: ''),
      );

  LoginState copyWith({Usuario usuario}) =>
      LoginState(usuario: usuario ?? this.usuario);

  @override
  List<Object> get props => [usuario];
}
