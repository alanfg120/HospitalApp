part of 'citas_bloc.dart';

class CitasState extends Equatable {
  final bool loading;

  CitasState({this.loading});
  factory CitasState.initial() {
    final loading = false;
    return CitasState(loading: loading);
  }
  CitasState copyWith({bool loading}) =>
      CitasState(loading: loading ?? this.loading);

  @override
  List<Object> get props => [];
}
