import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hospitalapp/src/componetes/login/data/login_repocitorio.dart';
import 'package:hospitalapp/src/componetes/login/models/usuario_model.dart';
import 'package:hospitalapp/src/componetes/login/vistas/login_page.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepocitorio repocitorio;
  LoginBloc({this.repocitorio});
  @override
  LoginState get initialState => InitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is VericarLoginEvent) yield* _verificarLogin();
    if (event is RegistroEvent) yield* _registro(event);
    if (event is AuthEvent) yield* _auth(event);
  }

  Stream<LoginState> _verificarLogin() async* {
    final usuario = await repocitorio.getUsuario();
    if (usuario.token.isEmpty)
      yield AutenticandoState(usuario: usuario);
    else
      yield AutenticadoState(usuario: usuario);
  }

  Stream<LoginState> _registro(RegistroEvent event) async* {
    final status = await repocitorio.setUsuario(event.usuario);
    switch (status) {
      case 'REGISTRADO':
        yield AutenticandoState(usuario: event.usuario, registro: status);
        yield AutenticandoState(usuario: event.usuario, registro: "INITIAL");
        break;
      case 'DUPLICADO':
        yield AutenticandoState(usuario: event.usuario, registro: status);
        yield AutenticandoState(usuario: event.usuario, registro: "INITIAL");
        break;
      case 'ERROR':
        yield AutenticandoState(usuario: event.usuario, registro: status);
        yield AutenticandoState(usuario: event.usuario, registro: "INITIAL");
        break;
      default:
        break;
    }
  }

  Stream<LoginState> _auth(AuthEvent event) async* {
    final usuario = await repocitorio.auth(event.usuario);
    if (usuario.token != null)
      yield AutenticadoState(usuario: usuario);
    else
      yield AutenticandoState(usuario: usuario,registro: "ERROR");
  }
}
