import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/model/launch/launch.dart';
import 'package:spacex_app/repository/spacex_repository.dart';

part 'launches_detail_event.dart';
part 'launches_detail_state.dart';

class LaunchesDetailBloc
    extends Bloc<LaunchesDetailEvent, LaunchesDetailState> {
  LaunchesDetailBloc(
    this._repository,
    this._launchesId,
  ) : super(const LaunchesDetailState()) {
    on<LoadByIdEvent>(_onLoadByIdEvent);
  }

  final String _launchesId;
  final SpacexRepository _repository;

  Future<void> _onLoadByIdEvent(
    LoadByIdEvent event,
    Emitter<LaunchesDetailState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final data = await _repository.getById(id: _launchesId);
      emit(state.copyWith(content: data));
    } catch (err) {
      emit(state.copyWith(content: null));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
