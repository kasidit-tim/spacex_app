part of 'home_bloc.dart';

class HomeState extends Equatable {
  final PaginationModel<LaunchModel> data;
  final PaginationModel<LaunchModel> baseData;
  final bool loading;
  final bool isLoadMore;
  final LaunchFilter filter;

  const HomeState({
    required this.data,
    required this.baseData,
    this.loading = false,
    this.isLoadMore = false,
    required this.filter,
  });

  HomeState copyWith({
    final PaginationModel<LaunchModel>? data,
    final PaginationModel<LaunchModel>? baseData,
    final bool? loading,
    final bool? isLoadMore,
    final LaunchFilter? filter,
  }) {
    return HomeState(
      data: data ?? this.data,
      baseData: baseData ?? this.baseData,
      loading: loading ?? this.loading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
        data,
        baseData,
        loading,
        isLoadMore,
        filter,
      ];
}
