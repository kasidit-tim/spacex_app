import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spacex_app/model/launch_filter.dart';
import 'package:spacex_app/model/pagination.dart';
import 'package:spacex_app/model/launch/launch.dart';
import 'package:spacex_app/repository/spacex_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

final preData = PaginationModel<LaunchModel>.empty();
final prefilter = LaunchFilter.empty();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository)
      : super(HomeState(
          data: preData,
          baseData: preData,
          filter: prefilter,
        )) {
    on<LoadEvent>(_onLoadEvent);
    on<LoadMoreEvent>(_onLoadMoreEvent);
    on<ResetSearchEvent>(_onResetSearchEvent);
  }

  final SpacexRepository _repository;

  Future<void> _onLoadEvent(
    LoadEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final data = await _repository.getContent(
        filter: event.filter ?? prefilter,
      );

      emit(state.copyWith(
        data: data,
        baseData: (state.baseData == preData) ? data : null,
        filter: event.filter,
      ));
    } catch (err) {
      debugPrint(err.toString());
      emit(state.copyWith(
        data: null,
        baseData: null,
        filter: prefilter,
      ));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> _onLoadMoreEvent(
    LoadMoreEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoadMore: true));
    try {
      final data = await _repository.getContent(
        filter: event.filter ?? prefilter,
      );

      final combinedDocs = [
        ...state.data.docs,
        ...data.docs,
      ];

      final newData = data.copyWith(docs: combinedDocs);
      emit(state.copyWith(
        data: newData,
        filter: event.filter,
      ));
    } catch (err) {
      debugPrint(err.toString());
    } finally {
      emit(state.copyWith(isLoadMore: false));
    }
  }

  void _onResetSearchEvent(
    ResetSearchEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(loading: true));
    emit(state.copyWith(
      data: state.baseData,
      filter: prefilter,
    ));
    emit(state.copyWith(loading: false));
  }
}
