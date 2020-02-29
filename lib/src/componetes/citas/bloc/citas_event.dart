part of 'citas_bloc.dart';

@immutable
abstract class CitasEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SolicitarTurnoEvent extends CitasEvent {
  final Turno turno;
  SolicitarTurnoEvent({this.turno});
  @override
  List<Object> get props => [turno];
}
