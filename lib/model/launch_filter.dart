enum SortNameType {
  asc,
  desc,
}

enum SortFlightNumberType {
  asc,
  desc,
}

class LaunchFilter {
  final int page;
  String? search;
  SortNameType? sortName;
  SortFlightNumberType? sortFlightNumber;

  LaunchFilter({
    required this.page,
    this.sortName,
    this.sortFlightNumber,
    this.search,
  });

  factory LaunchFilter.empty() {
    return LaunchFilter(
      page: 1,
      search: null,
      sortName: null,
      sortFlightNumber: null,
    );
  }

  LaunchFilter copyWith({
    int? page,
    String? search,
    SortNameType? sortName,
    SortFlightNumberType? sortFlightNumber,
    bool isResetSearch = false,
  }) {
    return LaunchFilter(
      page: page ?? this.page,
      search: isResetSearch ? null : search ?? this.search,
      sortName: sortName ?? this.sortName,
      sortFlightNumber: sortFlightNumber ?? this.sortFlightNumber,
    );
  }
}
