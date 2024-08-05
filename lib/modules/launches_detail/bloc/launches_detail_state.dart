part of 'launches_detail_bloc.dart';

class LaunchesDetailState extends Equatable {
  const LaunchesDetailState({
    this.content,
    this.loading = false,
  });

  final LaunchModel? content;
  final bool loading;

  LaunchesDetailState copyWith({
    final LaunchModel? content,
    final bool? loading,
  }) {
    return LaunchesDetailState(
      content: content ?? this.content,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        content,
        loading,
      ];
}
