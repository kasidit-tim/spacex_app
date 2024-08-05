part of 'launches_detail_bloc.dart';

abstract class LaunchesDetailEvent extends Equatable {
  const LaunchesDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadByIdEvent extends LaunchesDetailEvent {
  const LoadByIdEvent();
}
