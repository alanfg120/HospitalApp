part of 'citas_bloc.dart';

class CitasState extends Equatable {
  final StatusCitas status;
  CitasState({this.status});
  factory CitasState.initial() {
    final status = StatusCitas.inicial;
    return CitasState(status: status);
  }
  CitasState copyWith({bool loading}) =>
      CitasState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
