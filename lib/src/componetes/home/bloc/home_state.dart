part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool notificationBadge;
  final bool chatmessajeBadge;
  final int numberBadgetNotification;
  final int numberBadgeChatMessaje;

  HomeState(
      {this.notificationBadge,
      this.chatmessajeBadge,
      this.numberBadgeChatMessaje,
      this.numberBadgetNotification});

  factory HomeState.initial() {
    return HomeState(
        chatmessajeBadge: false,
        notificationBadge: false,
        numberBadgeChatMessaje: 0,
        numberBadgetNotification: 0);
  }
  HomeState copyWith(
      {bool notificationBadge,
      bool chatmessajeBadge,
      int numberBadgetNotification,
      int numberBadgeChatMessaje}) {
    return HomeState(
        chatmessajeBadge: chatmessajeBadge ?? this.chatmessajeBadge,
        notificationBadge: notificationBadge ?? this.notificationBadge,
        numberBadgeChatMessaje:
            numberBadgeChatMessaje ?? this.numberBadgeChatMessaje,
        numberBadgetNotification:
            numberBadgetNotification ?? this.numberBadgetNotification);
  }

  @override
  List<Object> get props => [
        notificationBadge,
        chatmessajeBadge,
        numberBadgetNotification,
        numberBadgeChatMessaje
      ];
}
