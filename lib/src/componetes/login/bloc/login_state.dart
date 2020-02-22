part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class AutenticandoState extends LoginState {
  final Usuario usuario;
  final String  registro;
  AutenticandoState({this.usuario,this.registro});
  factory AutenticandoState.initial()=>
          AutenticandoState(
          usuario: Usuario(
                   cedula   : '',
                   email    : '',
                   nombre   : '',
                   password : '',
                   token    : ''
                   ),
          registro: 'Inicial'
        );
  AutenticandoState copyWith({Usuario usuario,String  registro})
  => AutenticandoState(usuario: usuario ?? this.registro,registro: registro ?? registro);
  @override
  List<Object> get props => [usuario,registro];
}



class AutenticadoState extends LoginState {
  final Usuario usuario;
  AutenticadoState({this.usuario});
  @override
  List<Object> get props => [usuario];
}
class InitialState extends LoginState {}
/* class LoginState extends Equatable {
  final Usuario usuario;
  
  LoginState({this.usuario});

  factory LoginState.initial() => LoginState(
        usuario: Usuario(password: '', email: '', nombre: '', cedula: ''),
      );

  LoginState copyWith({Usuario usuario}) =>
      LoginState(usuario: usuario ?? this.usuario);

  @override
  List<Object> get props => [usuario];
} */
