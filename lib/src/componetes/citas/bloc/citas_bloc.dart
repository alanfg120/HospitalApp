import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitalapp/src/componetes/citas/data/citas_repositorio.dart';
import 'package:hospitalapp/src/componetes/citas/models/status_model.dart';
import 'package:hospitalapp/src/componetes/citas/models/turno_model.dart';
import 'package:meta/meta.dart';

part 'citas_event.dart';
part 'citas_state.dart';

class CitasBloc extends Bloc<CitasEvent, CitasState> {
  final CitasRepocitorio repocitorio;
  CitasBloc({this.repocitorio});
  @override
  CitasState get initialState => CitasState.initial();

  @override
  Stream<CitasState> mapEventToState(
    CitasEvent event,
  ) async* {
    if(event is SolicitarTurnoEvent) yield* _solicitarTurno(event);

  }

   Stream<CitasState> _solicitarTurno(SolicitarTurnoEvent event) async*{
     yield CitasState(status: StatusCitas.loading);
     final resp = await repocitorio.sendTurno(event.turno);
     yield CitasState(status: resp);
    
   }
}
