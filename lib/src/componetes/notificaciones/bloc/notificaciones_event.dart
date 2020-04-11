part of 'notificaciones_bloc.dart';

@immutable
abstract class NotificacionesEvent extends Equatable {}

class GetNotificacionesEvent extends NotificacionesEvent {
  final String cedula;
  GetNotificacionesEvent({this.cedula});
  @override
  List<Object> get props => [cedula];
}

class AddNotificacionEvent extends NotificacionesEvent {
  final Notificacion notificacion;
  AddNotificacionEvent({this.notificacion});
  @override
  List<Object> get props => [notificacion];
}

class ReadNotificacionEvent extends NotificacionesEvent {
  final Notificacion notificacion;
  ReadNotificacionEvent({this.notificacion});
  @override
  List<Object> get props => [notificacion];
}

class ResetNotificacionEvent extends NotificacionesEvent {
  @override
  List<Object> get props => [];
}
