// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchModel _$LaunchModelFromJson(Map<String, dynamic> json) => LaunchModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      flightNumber: (json['flight_number'] as num).toInt(),
      details: json['details'] as String?,
      success: json['success'] as bool?,
      links: json['links'] == null
          ? null
          : LinksModel.fromJson(json['links'] as Map<String, dynamic>),
      fireDate: json['static_fire_date_utc'] == null
          ? null
          : DateTime.parse(json['static_fire_date_utc'] as String),
      crew: (json['crew'] as List<dynamic>?)
          ?.map((e) => CrewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LaunchModelToJson(LaunchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'success': instance.success,
      'links': instance.links,
      'crew': instance.crew,
      'static_fire_date_utc': instance.fireDate?.toIso8601String(),
      'flight_number': instance.flightNumber,
    };

LinksModel _$LinksModelFromJson(Map<String, dynamic> json) => LinksModel(
      images:
          LinksModel._getOriginalImage(json['flickr'] as Map<String, dynamic>),
      logo: LinksModel._getLargeIcon(json['patch'] as Map<String, dynamic>?),
      videoUrl: json['webcast'] as String?,
    );

Map<String, dynamic> _$LinksModelToJson(LinksModel instance) =>
    <String, dynamic>{
      'flickr': instance.images,
      'patch': instance.logo,
      'webcast': instance.videoUrl,
    };

CrewModel _$CrewModelFromJson(Map<String, dynamic> json) => CrewModel(
      crew: json['crew'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$CrewModelToJson(CrewModel instance) => <String, dynamic>{
      'crew': instance.crew,
      'role': instance.role,
    };
