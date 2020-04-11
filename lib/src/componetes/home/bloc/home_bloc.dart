import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeState.initial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is AddChatMensajeEvent) yield* _addChatBadget(state);
    if (event is AddNotificationEvent) yield* _addNotificationBadget(state);
    if (event is ResetChatMensajeEvent) yield* _resetChatBadget(state);
    if (event is ResetNotificationEvent) yield* _resetNotificationBadget(state);
  }

  Stream<HomeState> _addChatBadget(HomeState state) async* {
    final number = state.numberBadgeChatMessaje + 1;
    yield state.copyWith(
        numberBadgeChatMessaje: number, chatmessajeBadge: true);
  }

  Stream<HomeState> _resetChatBadget(HomeState state) async* {
    yield state.copyWith(chatmessajeBadge: false, numberBadgeChatMessaje: 0);
  }

  Stream<HomeState> _resetNotificationBadget(HomeState state) async* {
    yield state.copyWith(notificationBadge: false, numberBadgetNotification: 0);
  }

  Stream<HomeState> _addNotificationBadget(HomeState state) async* {
    final number = state.numberBadgetNotification + 1;
    yield state.copyWith(
        numberBadgetNotification: number, notificationBadge: true);
  }
}
