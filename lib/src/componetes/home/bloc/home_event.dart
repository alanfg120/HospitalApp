part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable{}



class GetNewNotificationEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}
class AddChatMensajeEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}

class AddNotificationEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}
class ResetChatMensajeEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}
class ResetNotificationEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}