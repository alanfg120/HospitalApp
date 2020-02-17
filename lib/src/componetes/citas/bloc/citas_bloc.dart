import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitalapp/src/componetes/citas/data/citas_repositorio.dart';
import 'package:meta/meta.dart';

part 'citas_event.dart';
part 'citas_state.dart';

class CitasBloc extends Bloc<CitasEvent, CitasState> {
  final CitasRepocitorio repocitorio;
  CitasBloc({this.repocitorio});
  @override
  CitasState get initialState => CitasInitial();

  @override
  Stream<CitasState> mapEventToState(
    CitasEvent event,
  ) async* {}
}
