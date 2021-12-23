import 'package:json_annotation/json_annotation.dart';

import 'package:hanbat/models/model.dart';

part 'open_api.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenAPI {
  final SearchBase home;

  OpenAPI({
    required this.home,
  });

  factory OpenAPI.fromJson(Map<String, dynamic> json) =>
      _$OpenAPIFromJson(json);
  Map<String, dynamic> toJson() => _$OpenAPIToJson(this);
}