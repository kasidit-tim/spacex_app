import 'package:equatable/equatable.dart';

class PaginationModel<SpaceXModel> extends Equatable {
  final List<SpaceXModel> docs;
  final int totalDocs;
  final int limit;
  final int page;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int? nextPage;

  const PaginationModel({
    required this.docs,
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.limit,
    required this.nextPage,
    required this.page,
    required this.totalDocs,
  });

  factory PaginationModel.fromJson(
      Map<String, dynamic> json, List<SpaceXModel> docs) {
    return PaginationModel(
        docs: docs,
        hasNextPage: json['hasNextPage'] ?? false,
        hasPrevPage: json['hasPrevPage'] ?? false,
        limit: json['limit'],
        nextPage: json['nextPage'],
        page: json['page'],
        totalDocs: json['totalDocs']);
  }

  factory PaginationModel.empty() {
    return const PaginationModel(
        docs: [],
        hasNextPage: false,
        hasPrevPage: false,
        limit: 0,
        nextPage: null,
        page: 1,
        totalDocs: 0);
  }

  PaginationModel<SpaceXModel> copyWith({
    List<SpaceXModel>? docs,
    int? totalDocs,
    int? limit,
    int? page,
    bool? hasNextPage,
    bool? hasPrevPage,
    int? nextPage,
  }) {
    return PaginationModel<SpaceXModel>(
      docs: docs ?? this.docs,
      totalDocs: totalDocs ?? this.totalDocs,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  @override
  List<Object?> get props => [docs];
}
