part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SendMensajeEvent extends ChatEvent{
  final Mensaje mensaje;
  SendMensajeEvent({this.mensaje});
  @override
  List<Object> get props => [mensaje];
}
class RequestMensajeEvent extends ChatEvent{
  final Mensaje mensaje;
  RequestMensajeEvent({this.mensaje});
  @override
  List<Object> get props => [mensaje];
}

class GetMensajesEvent extends ChatEvent {}