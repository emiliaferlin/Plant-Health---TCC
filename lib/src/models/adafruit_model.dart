// To parse this JSON data, do
//
//     final FeedModel = FeedModelFromMap(jsonString);

import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) =>
    List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromMap(x)));

String feedModelToJson(List<FeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class FeedModel {
  dynamic id;
  String? value;
  int? feedId;
  String? feedKey;
  DateTime? createdAt;
  int? createdEpoch;
  DateTime? expiration;

  FeedModel({
    this.id,
    this.value,
    this.feedId,
    this.feedKey,
    this.createdAt,
    this.createdEpoch,
    this.expiration,
  });

  FeedModel copyWith({
    dynamic id,
    String? value,
    int? feedId,
    String? feedKey,
    DateTime? createdAt,
    int? createdEpoch,
    DateTime? expiration,
  }) => FeedModel(
    id: id ?? this.id,
    value: value ?? this.value,
    feedId: feedId ?? this.feedId,
    feedKey: feedKey ?? this.feedKey,
    createdAt: createdAt ?? this.createdAt,
    createdEpoch: createdEpoch ?? this.createdEpoch,
    expiration: expiration ?? this.expiration,
  );

  factory FeedModel.fromMap(Map<String, dynamic> json) => FeedModel(
    id: json["id"],
    value: json["value"],
    feedId: json["feed_id"],
    feedKey: json["feed_key"],
    createdAt:
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    createdEpoch: json["created_epoch"],
    expiration:
        json["expiration"] != null ? DateTime.parse(json["expiration"]) : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "value": value,
    "feed_id": feedId,
    "feed_key": feedKey,
    "created_at": createdAt?.toIso8601String(),
    "created_epoch": createdEpoch,
    "expiration": expiration?.toIso8601String(),
  };
}
