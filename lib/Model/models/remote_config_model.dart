import 'dart:convert';

RemoteConfigModel remoteConfigModelFromJson(String str) => RemoteConfigModel.fromJson(json.decode(str));

class RemoteConfigModel {
  String? url;

  RemoteConfigModel({
    this.url,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) => RemoteConfigModel(
    url: json["url"] ?? '',
  );
}
