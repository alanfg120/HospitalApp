part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingChatState extends ChatState {}

class LoadMensajesState extends ChatState {
  final List<Mensaje> mensajes;
  final Mensaje mensaje;
  LoadMensajesState({this.mensajes, this.mensaje});

  LoadMensajesState copyWith({List<Mensaje> mensajes, Mensaje mensaje}) {
    return LoadMensajesState(
        mensaje: mensaje ?? this.mensaje, mensajes: mensajes ?? this.mensajes);
  }

  @override
  List<Object> get props => [mensajes, mensaje];
}
