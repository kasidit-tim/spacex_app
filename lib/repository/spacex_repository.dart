import 'package:spacex_app/constants/api.dart';
import 'package:spacex_app/core/network/network.dart';
import 'package:spacex_app/model/launch_filter.dart';
import 'package:spacex_app/model/pagination.dart';
import 'package:spacex_app/model/launch/launch.dart';

class SpacexRepository {
  final AppNetwork _network;

  SpacexRepository(this._network);

  Future<PaginationModel<LaunchModel>> getContent({
    required LaunchFilter filter,
  }) async {
    final res = await _network.post(
      '${SpacexUrl.getAll}/query',
      data: {
        "query": filter.search != null
            ? {
                "name": {"\$regex": filter.search!, "\$options": "i"}
              }
            : {},
        "options": {
          "limit": 20,
          "page": filter.page,
          if (filter.sortName != null)
            "sort": {
              "name": filter.sortName == SortNameType.asc ? "asc" : "desc",
            },
          if (filter.sortFlightNumber != null)
            "sort": {
              "flight_number":
                  filter.sortFlightNumber == SortFlightNumberType.asc
                      ? "asc"
                      : "desc",
            },
          "collation": {
            "locale": "en",
            "strength": 2,
          }
        }
      },
    );

    List<LaunchModel> docs = LaunchModel.parseList(res.data['docs']);
    return PaginationModel<LaunchModel>.fromJson(
      res.data,
      docs,
    );
  }

  Future<LaunchModel> getById({
    required String id,
  }) async {
    final res = await _network.get(
      '${SpacexUrl.getById(id)}',
    );
    return LaunchModel.fromJson(res.data);
  }
}
