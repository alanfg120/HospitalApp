import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitalapp/src/componetes/notificaciones/data/notificacions_repositorio.dart';
import 'package:hospitalapp/src/componetes/notificaciones/models/notificacion_model.dart';
import 'package:meta/meta.dart';

part 'notificaciones_event.dart';
part 'notificaciones_state.dart';

class NotificacionesBloc
    extends Bloc<NotificacionesEvent, NotificacionesState> {
      
  final NotificacionesRepocitorio repocitorio;
  NotificacionesBloc({this.repocitorio});

  @override
  NotificacionesState get initialState => NotificacionesInitial();

  @override
  Stream<NotificacionesState> mapEventToState(
    NotificacionesEvent event,
  ) async* {
   
  }
}
