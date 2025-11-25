import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) =>
    List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
  String username;
  OwnerModel owner;
  int id;
  String name;
  String description;
  dynamic license;
  bool history;
  bool enabled;
  String visibility;
  dynamic unitType;
  dynamic unitSymbol;
  String lastValue;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic wipperPinInfo;
  bool statusNotify;
  int statusTimeout;
  String status;
  String key;
  GroupModel group;
  List<GroupModel> groups;
  List<dynamic> feedWebhookReceivers;
  List<FeedStatusChangeModel> feedStatusChanges;

  FeedModel({
    required this.username,
    required this.owner,
    required this.id,
    required this.name,
    required this.description,
    required this.license,
    required this.history,
    required this.enabled,
    required this.visibility,
    required this.unitType,
    required this.unitSymbol,
    required this.lastValue,
    required this.createdAt,
    required this.updatedAt,
    required this.wipperPinInfo,
    required this.statusNotify,
    required this.statusTimeout,
    required this.status,
    required this.key,
    required this.group,
    required this.groups,
    required this.feedWebhookReceivers,
    required this.feedStatusChanges,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
    username: json["username"],
    owner: OwnerModel.fromJson(json["owner"]),
    id: json["id"],
    name: json["name"],
    description: json["description"],
    license: json["license"],
    history: json["history"],
    enabled: json["enabled"],
    visibility: json["visibility"],
    unitType: json["unit_type"],
    unitSymbol: json["unit_symbol"],
    lastValue: json["last_value"].toString(),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    wipperPinInfo: json["wipper_pin_info"],
    statusNotify: json["status_notify"],
    statusTimeout: json["status_timeout"],
    status: json["status"],
    key: json["key"],
    group: GroupModel.fromJson(json["group"]),
    groups: List<GroupModel>.from(
      json["groups"].map((x) => GroupModel.fromJson(x)),
    ),
    feedWebhookReceivers: List<dynamic>.from(
      json["feed_webhook_receivers"].map((x) => x),
    ),
    feedStatusChanges: List<FeedStatusChangeModel>.from(
      json["feed_status_changes"].map((x) => FeedStatusChangeModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "owner": owner.toJson(),
    "id": id,
    "name": name,
    "description": description,
    "license": license,
    "history": history,
    "enabled": enabled,
    "visibility": visibility,
    "unit_type": unitType,
    "unit_symbol": unitSymbol,
    "last_value": lastValue,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "wipper_pin_info": wipperPinInfo,
    "status_notify": statusNotify,
    "status_timeout": statusTimeout,
    "status": status,
    "key": key,
    "group": group.toJson(),
    "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
    "feed_webhook_receivers": List<dynamic>.from(
      feedWebhookReceivers.map((x) => x),
    ),
    "feed_status_changes": List<dynamic>.from(
      feedStatusChanges.map((x) => x.toJson()),
    ),
  };
}

class OwnerModel {
  int id;
  String username;

  OwnerModel({required this.id, required this.username});

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      OwnerModel(id: json["id"], username: json["username"]);

  Map<String, dynamic> toJson() => {"id": id, "username": username};
}

class GroupModel {
  int id;
  String key;
  String name;
  int userId;

  GroupModel({
    required this.id,
    required this.key,
    required this.name,
    required this.userId,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    id: json["id"],
    key: json["key"],
    name: json["name"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "name": name,
    "user_id": userId,
  };
}

class FeedStatusChangeModel {
  DateTime createdAt;
  String fromStatus;
  String toStatus;
  dynamic emailSent;
  dynamic emailSentTo;

  FeedStatusChangeModel({
    required this.createdAt,
    required this.fromStatus,
    required this.toStatus,
    required this.emailSent,
    required this.emailSentTo,
  });

  factory FeedStatusChangeModel.fromJson(Map<String, dynamic> json) =>
      FeedStatusChangeModel(
        createdAt: DateTime.parse(json["created_at"]),
        fromStatus: json["from_status"],
        toStatus: json["to_status"],
        emailSent: json["email_sent"],
        emailSentTo: json["email_sent_to"],
      );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt.toIso8601String(),
    "from_status": fromStatus,
    "to_status": toStatus,
    "email_sent": emailSent,
    "email_sent_to": emailSentTo,
  };
}
