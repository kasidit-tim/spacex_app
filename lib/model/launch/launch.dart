import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'launch.g.dart';

@JsonSerializable()
class LaunchModel extends Equatable {
  final String id;
  final String? name;
  final String? details;
  final bool? success;
  final LinksModel? links;
  final List<CrewModel>? crew;
  @JsonKey(name: 'static_fire_date_utc')
  final DateTime? fireDate;
  @JsonKey(name: 'flight_number')
  final int flightNumber;

  const LaunchModel({
    required this.id,
    this.name,
    required this.flightNumber,
    this.details,
    this.success,
    this.links,
    this.fireDate,
    this.crew,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) =>
      _$LaunchModelFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchModelToJson(this);

  static parseList(List<dynamic> list) {
    return list.map((e) => LaunchModel.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class LinksModel extends Equatable {
  @JsonKey(name: "flickr", fromJson: _getOriginalImage)
  final List<dynamic>? images;
  @JsonKey(name: "patch", fromJson: _getLargeIcon)
  final String? logo;
  @JsonKey(name: "webcast")
  final String? videoUrl;

  const LinksModel({
    this.images,
    this.logo,
    this.videoUrl,
  });

  static List<dynamic> _getOriginalImage(Map<String, dynamic> data) {
    if (data.containsKey('original')) {
      return data['original'];
    }
    return [];
  }

  static String? _getLargeIcon(Map<String, dynamic>? data) {
    if (data != null && data.containsKey('large')) {
      return data['large'];
    }
    return null;
  }

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);

  @override
  List<Object?> get props => [
        images,
        logo,
        videoUrl,
      ];
}

@JsonSerializable()
class CrewModel extends Equatable {
  final String crew;
  final String role;

  const CrewModel({
    required this.crew,
    required this.role,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) =>
      _$CrewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CrewModelToJson(this);

  @override
  List<Object?> get props => [
        crew,
        role,
      ];
}
