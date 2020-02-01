import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hospitalapp/src/componetes/chat/models/chat_model.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  @override
  ChatState get initialState => LoadingChatState();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is SendMensajeEvent) yield* _sendMensaje(event, state);
    if (event is GetMensajesEvent) yield* _getMensajes();
  }

  Stream<ChatState> _sendMensaje(
      SendMensajeEvent event, LoadMensajesState state) async* {
    if (event.mensaje.mensaje.isNotEmpty) {
       event.mensaje.recibido = false;
       state.mensajes.add(event.mensaje);
      final mensaje = Mensaje(id: "1", mensaje: '',recibido: false);
      yield state.copyWith(mensajes: state.mensajes, mensaje: mensaje);
    }
 
  }

  Stream<ChatState> _getMensajes() async* {
    final mensaje = Mensaje(id: "1", fecha: DateTime.now(), mensaje: '');
    yield LoadMensajesState(mensajes: [], mensaje: mensaje);
  }
}
